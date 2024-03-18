//
//  Restaurant.swift
//  MyTable
//
//  Created by Pascal Couturier on 20/8/2023.
//

import Foundation
import CoreData

// Restaurant model for all restaurant mapping
/// Restaurant Model that is used to display restaurant data to users
/// 
struct RestaurantModel: Codable, Identifiable{
    
    enum CodingKeys: CodingKey {
        case venueId
        case name
        case slug
        case cuisine
        case image
        case distance
        case rating
        case phone
        case websiteUrl
        case menuUrl
        case featuredImages
        case latitude
        case longitude
        case numOfQueue
        case inQueue
        
        case validationCode
        
        case mainImage
        case subImage1
        case subImage2
        case subImage3
        case subImage4
    }
    
    var id = UUID()
    var venueId: String
    var name: String
    var slug: String
    var cuisine: String
    var image: Data?
    var distance: Double
    var rating: Double
    var phone: String
    var websiteUrl: String
    var menuUrl: String
    var featuredImages: [Data]?
    var latitude : Double
    var longitude : Double
    var numOfQueue : String
    var inQueue : String
    var validationCode : String
    
    // TODO: convert these duplicate items to an array
    var mainImage: Data?
    var subImage1: Data?
    var subImage2: Data?
    var subImage3: Data?
    var subImage4: Data?
    
   
}

extension LoadRestaurantData: Identifiable {}

// Load restaurant data
/// Loads the restaurants data, if in preview or no restaurants stored then loads dummy data, otherwise gets it from core data
class LoadRestaurantData: ObservableObject {
    @Published var restaurants = [RestaurantModel]()
    
    // load on instantiation
    // Initialize LoadRestaurantData with a ManagedObjectContext
    init() {
        loadRestaurants()
    }
    
    // TODO: This currently load dummy data from a json file
    /// Loads the restaurant default dummy data
    func loadRestaurants() {
        
        //        guard let url = Bundle.main.url(forResource: "RestaurantData", withExtension: "json")
        //        else {
        //            print("Json file not found")
        //            return
        //        }
        //        let data = try? Data(contentsOf: url)
        //        let restaurants = try? JSONDecoder().decode([RestaurantModel].self, from: data!)
        //        self.restaurants = restaurants!
        
    }
    
    // update restaurants from stored coreData
    /// Loads the Restaurant data from the core data store, but if none present then it loads the dummy data
    /// - Parameter context: context of the core data to access it's store
    func updateRestaurantsFromStoredData(context: NSManagedObjectContext?) {
        if (context != nil) {
            let restaurantsFromCoreData = RestaurantsMappingHelper(context: context!).getRestaurants()
            
            if (restaurantsFromCoreData.isEmpty) {
                loadRestaurants()
            } else {
                self.restaurants = restaurantsFromCoreData
            }
        } else {
            loadRestaurants()
        }
    }
    
}
