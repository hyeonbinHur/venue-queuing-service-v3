//
//  RestaurantMappingHelper.swift
//  MyTable
//
//  Created by Pascal Couturier on 7/10/2023.
//

import Foundation
import CoreData

/// Helper to assist with mapping data from stored information i.e. Core Data or database to the Model being used in the application
/// It's helpful in case the data source changes we can update the mapping here and not need to change it in all other locations, just the mapping section
struct RestaurantsMappingHelper {
    // Access the managed stored data object
    let moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
    }
    
    
    // get all the restaurants and return with the restaurant model
    /// Get all the restaurants that are stored and used for frontend display to users
    /// - Returns: `[RestaurantModel]` -> an array of restaurants used for displaying to front end users, if none, then an empy array `[]`
    func getRestaurants() -> [RestaurantModel] {
        if let restaurants = getStoredRestaurantsFromCoreData() {
            return mapAllRestaurantDataList(restaurantsDataList: restaurants)
        } else {
            return []
        }
    }
    
    // get all restaurants from core Data
    /// Gets the restaurants from the core Data
    /// - Returns: `[Restaurant]` -> an array of restaurants from the Core Data stored model, if none present then returns `nil`
    func getStoredRestaurantsFromCoreData() -> [Restaurant]? {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest() as! NSFetchRequest<Restaurant>
        
        do {
            let results = try self.moc.fetch(fetchRequest)
            return results
        } catch {
            print("Error fetching object by ID: \(error)")
            return nil
        }
    }
    
    // map stored restaurant data to RestaurantModel only for a single instance
    /// This maps the `Restaurant` data from core data to the `RestaurantModel` that is used for frontend display to users
    /// - Parameter restaurantData: A single restaurant object obtained from core data store
    /// - Returns: `RestaurantModel` -> Single object that is used for frontend display
    func mapStoredRestaurantToRestaurantModel(restaurantData: Restaurant) -> RestaurantModel {
        var restaurant = RestaurantModel(venueId: restaurantData.venueId, name: restaurantData.name, slug: restaurantData.slug, cuisine: restaurantData.cuisine, image: restaurantData.mainImage, distance: 1.0, rating: 1.2, phone: restaurantData.phone, websiteUrl: restaurantData.websiteUrl, menuUrl: restaurantData.menuUrl, featuredImages: [], latitude: restaurantData.latitude, longitude: restaurantData.longitude, numOfQueue: restaurantData.numOfQueue, inQueue: restaurantData.inQueue, validationCode: restaurantData.validationCode, mainImage: restaurantData.mainImage, subImage1: restaurantData.subImage1, subImage2: restaurantData.subImage2, subImage3: restaurantData.subImage3, subImage4: restaurantData.subImage4)
        
        // TODO: fix this to make a better way of managing the data for images
        
        if (restaurantData.mainImage != nil) {
            restaurant.featuredImages?.append(restaurantData.mainImage!)
        }
        if (restaurantData.subImage1 != nil) {
            restaurant.featuredImages?.append(restaurantData.subImage1!)
        }
        if (restaurantData.subImage2 != nil) {
            restaurant.featuredImages?.append(restaurantData.subImage2!)
        }
        if (restaurantData.subImage3 != nil) {
            restaurant.featuredImages?.append(restaurantData.subImage3!)
        }
        if (restaurantData.subImage4 != nil) {
            restaurant.featuredImages?.append(restaurantData.subImage4!)
        }
        return restaurant
    }
    
    // go through every restaurant in stored core data and map each to a new restaurant model array
    /// Maps an array of `Restaurant` data from Core Data store to the front end usable `RestaurantModel` array
    /// - Parameter restaurantsDataList: `[Restaurant]` an array of restaurant data from Core data
    /// - Returns: `[RestaurantModel]` an array of restaurant model for use in frontend for users, if none, then an empty array `[]`
    func mapAllRestaurantDataList(restaurantsDataList: [Restaurant]) -> [RestaurantModel] {
        var restaurantModelList: [RestaurantModel] = []
        
        // if there is no list then don't do anything and return an empty array
        if (restaurantsDataList.isEmpty) {
            return []
        } else {
            for restaurant in restaurantsDataList {
                restaurantModelList.append(mapStoredRestaurantToRestaurantModel(restaurantData: restaurant))
            }
            return restaurantModelList
        }
    }
    
    /// When a team joined the queue, the information of the queue must be updated
    /// - Parameters:
    ///   - restaurant: the restaurant where new team join in a queue
    ///   - uuid: the joined usere user id
    func updateQueue(restaurant: RestaurantModel, uuid: String){
        if (!restaurant.venueId.isEmpty){
            var restaurantData = getStoredRestaurantByVenueId(venueId: restaurant.venueId, in: self.moc)
            if (restaurantData != nil) {
                restaurantData?.numOfQueue = restaurant.numOfQueue
                restaurantData?.inQueue = restaurant.inQueue+uuid
                try? self.moc.save()
            }
        }
    }
    
    func clearQueue(restaurant: RestaurantModel){
        if (!restaurant.venueId.isEmpty){
            var restaurantData = getStoredRestaurantByVenueId(venueId: restaurant.venueId, in: self.moc)
            if (restaurantData != nil) {
                restaurantData?.numOfQueue = "0"
                restaurantData?.inQueue = "" 
                try? self.moc.save()
            }
        }
    }

    func getStoredRestaurantByVenueId(venueId: String?, in context: NSManagedObjectContext) -> Restaurant? {
        if (venueId != nil) {
            let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest() as! NSFetchRequest<Restaurant>
            fetchRequest.predicate = NSPredicate(format: "venueId == %@", venueId!)
            
            do {
                let results = try context.fetch(fetchRequest)
                return results.first // Assuming ID is unique; use `first` to get the object or `nil` if not found.
            } catch {
                print("Error fetching object by ID: \(error)")
                return nil
            }
        } else {
            return nil
        }
    }
    
    
}
