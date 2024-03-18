//
//  MapModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 23/9/2023.
//
// Acknowledgment:
// Initial concept
// Week09 Lecture - Shekhar Kalra
// (Presented in lecture as demonstartion)

/**
 Usage examples:
 
 Parameters:
 
- `location` -> If only the location is passed through then it shows that single location on the map and uses it for the region, generally used when wanting to display a single venue MUST be used with `venuAddresses`

- `interactionMode` -> Can set if the map can be interacted with, by default it's all adjustable

- `venueAddresses` (String Array) -> if there are values in here then it uses these string address values to render the annotations on the map and the `location` above to set the region - MUST be used with `location`
 
 - `restaurantModelList` (Array of RestaurantModel) -> if provided, then it uses the longitude and latitude of each restaurant to display them on the map
 
 `location` MUST be provided when searching for single venue or using the  `venueAddresses` string array, if not provided when passing the `restaurantModelList` array through then the region is set to the location of the first restaurant in the list
 
 */

import SwiftUI
import MapKit

/// The map module that controls the map itself when used
/**
 Usage examples:
 
 Parameters:
 
- `location` -> If only the location is passed through then it shows that single location on the map and uses it for the region, generally used when wanting to display a single venue MUST be used with `venuAddresses`

- `interactionMode` -> Can set if the map can be interacted with, by default it's all adjustable

- `venueAddresses` (String Array) -> if there are values in here then it uses these string address values to render the annotations on the map and the `location` above to set the region - MUST be used with `location`
 
 - `restaurantModelList` (Array of RestaurantModel) -> if provided, then it uses the longitude and latitude of each restaurant to display them on the map
 
 `location` MUST be provided when searching for single venue or using the  `venueAddresses` string array, if not provided when passing the `restaurantModelList` array through then the region is set to the location of the first restaurant in the list
 
 **/
struct MapModule: View {
    @Binding var location: String
    // Interaction modes available are:
    // - pan
    // - zoom
    // - all
    var interactionMode: MapInteractionModes = .all
    
    @State var venueAddresses: [String] = []
    
    // This is the actual Restaurant object array as it should have the longitude and latitude saved to it
    @State var restaurantModelList: [RestaurantModel] = []
    // the filtered list is after it has been sorted from the region
    @State var filteredRestaurantList: [RestaurantModel] = []
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var annotatedItems: [AnnotatedItem] = []
    
    var body: some View {
        // run the map
        Map(coordinateRegion: $region, interactionModes: interactionMode, annotationItems: annotatedItems) { item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
        .task {
            // if only using the strings for addressess then use this method
            if (restaurantModelList.isEmpty) {
                convertAddress(location: location, venueAddresses: venueAddresses)
            } else {
                // if using restaurant objects for address longitude and latitude then use this section
                if let firstRestaurant = restaurantModelList.first {
                    let regionOfFirstRestaurant = CLLocationCoordinate2D(latitude: firstRestaurant.latitude, longitude: firstRestaurant.longitude)
                    // Set the region from first restaurant if location is empty
                    // otherwise use the location to set the region
                    if(location.isEmpty) {
                        getRegionFromLatitudeAndLongitude(center: regionOfFirstRestaurant)
                    } else {
                        getRegionFromLocation(location: location)
                    }
                    // filter the list
                    filterData(for: regionOfFirstRestaurant)
                    // add annotations
                    mapAnnotationDataFromRestaurantModel(restaurants: filteredRestaurantList)
                }
                
            }
        }
        // When the region changes (zoom out or zoom in) it updates the filtered list
        .onChange(of: region.center) { newCenter in
            filterData(for: newCenter)
            if (!restaurantModelList.isEmpty) {
                mapAnnotationDataFromRestaurantModel(restaurants: filteredRestaurantList)
            }
        }
        .onChange(of: location) { newlocation in
            convertAddress(location: location, venueAddresses: venueAddresses)
        }
    }
}

struct MapModule_Previews: PreviewProvider {
    static var previews: some View {
        // MARK: The below is an example of string values being passed through for annotations
        MapModule(location: .constant("1 Acland Street, St Kilda, Melbourne"), venueAddresses: ["1 Acland Street, St Kilda, Melbourne", "5 Acland Street, St Kilda, Melbourne", "6 Acland Street ,St Kilda, Melbourne"])
        
        // MARK: The below is an example of the restaurant object being passed through for annotated locations
        //        let restaurant1 = RestaurantModel(venueId: UUID().uuidString, name: "testing name", slug: "testing slug", cuisine: "italian", image: "", distance: 1.0, rating: 4.0, phone: "0400000000", websiteUrl: "http://#", menuUrl: "#", featuredImages: [], latitude: -37.813629, longitude: 144.963058, numOfQueue: 0, inQueue: [])
        //
        //
        //        MapModule(location: "1 Acland Street, St Kilda, Melbourne", restaurantModelList: [restaurant1])
    }
}


struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

extension MapModule {
    
    // As the restaurants have the latitude and longitude we can make annotation data from these fields
    /// Gets and maps the annotated items on the map from an array of restaurant models
    /// - Parameter restaurants: `[RestaurantModel` an array of restaurant data
    private func mapAnnotationDataFromRestaurantModel(restaurants: [RestaurantModel]) {
        
        if (!restaurants.isEmpty) {
            var annotationDataList: [AnnotatedItem] = []
            
            for restaurant in restaurants {
                // create a new annotated item from the restaurant data and add to list
                annotationDataList.append(AnnotatedItem(coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)) )
            }
            
            self.annotatedItems = annotationDataList
        }
    }
    
    // This runs the address conversion if using List of Syring addresses being passed through
    // if we use the RestaurantModel objects instead then we can map the values directly and not require translation from address
    /// Converts an address string and an array of addresses to points of interest on a map. if the array of addresses is empty then only uses the location to search
    /// - Parameters:
    ///   - location: `String` address
    ///   - venueAddresses: `[String]` a string of addresses
    private func convertAddress(location: String, venueAddresses: [String] = []) {
        
        // Get location
        let geoCoder = CLGeocoder()
        
        // if the location is the only thing being passed through and no venu addresses then only add that item
        // use this conditional option for a single address when displaying single specific restaurant details
        // MARK: when displaying a single pin on map (single restaurant)
        
        // TODO: correct to allow for region search with just the location and not setting point
        if (venueAddresses.isEmpty) {
            geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let placemarks = placemarks,
                      let location = placemarks[0].location else {
                    return
                }
                
                self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
                
                // TODO: remove this as it is setting the location for search, we want restaurants data to be here and loading not the exact address
                self.annotatedItems.append(AnnotatedItem(coordinate: location.coordinate))
            })
        } else {
            // MARK: When displaying multiple pins on map (multiple restaurants)
            // Set the region based on the single location string passed through i.e. address search
            getRegionFromLocation(location: location)
            // get addresses of all venues to use as the pins
            updateMultipleAnnotatedItemsFromStringArray(venueAddresses: venueAddresses)
        }
    }
    
    /// Updates the annotated items from the array of address strings
    /// - Parameter venueAddresses: `[String]` and array of address strings
    private func updateMultipleAnnotatedItemsFromStringArray(venueAddresses: [String] = []) {
        
        if (!venueAddresses.isEmpty) {
            
            // Clear the current annotatedItems list
            self.annotatedItems = []
            
            // Run through all the addresses in the string array
            for location in venueAddresses {
                
                // update each one and add to the list again
                getAnnotatedItemFromAddress(location: location)
            }
        }
    }
    
    // Returns the AnnotatedItem from a string address passed through
    /// Gets the annotated item from a single address string
    /// - Parameter location: `String` -> Address
    private func getAnnotatedItemFromAddress(location: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                return
            }
            
            self.annotatedItems.append(AnnotatedItem(coordinate: location.coordinate))
        }
    }
    
    // Attains the region from the String address value sent through
    // This could be used when manually entering an address in a search bar for the region
    /// Sets the region from the address string provided
    /// - Parameter location: `String` address
    private func getRegionFromLocation(location: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks[0].location else {
                return
            }
            
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
        })
    }
    
    // Attain region from longitude and latitiude
    /// Sets the region from the longitude and latitude, used when passing through RestaurantModel objects through
    /// - Parameter center: CLLocationCoordinate2D
    private func getRegionFromLatitudeAndLongitude(center: CLLocationCoordinate2D) {
        if (!center.latitude.isNaN && !center.longitude.isNaN) {
            self.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
        }
    }
    
    // Filters the data when the region changes
    // only used when comparing the restaurantModel data, not for string array of addresses
    // TODO: account for string array of addresses to filter
    /// Filters the data to display on the map so only the restaurants that fit within the region ar displayed
    /// - Parameter center: CLLocationCoordinate2D
    private func filterData(for center: CLLocationCoordinate2D) {
        // Calculate the boundaries of the visible region based on the center and span of the map
        let latitudeDelta = region.span.latitudeDelta
        let longitudeDelta = region.span.longitudeDelta
        
        // Run through the filter in this section if the data is coming from a restaurant list
        if (!restaurantModelList.isEmpty) {
            // filter by the restaurant list
            let filteredData = restaurantModelList.filter { item in
                let latDiff = abs(center.latitude - item.latitude)
                let lonDiff = abs(center.longitude - item.longitude)
                return latDiff <= latitudeDelta / 2 && lonDiff <= longitudeDelta / 2
            }
            
            filteredRestaurantList = filteredData
        }
    }
}
