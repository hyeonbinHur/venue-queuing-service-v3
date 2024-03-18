//
//  RestaurantProfileDataMapperHelper.swift
//  MyTable
//
//  Created by Pascal Couturier on 2/10/2023.
//

import Foundation
import CoreData

// This maps the restaurant to the restaurant profile model
/// Helper to assist with mapping data from stored information i.e. Core Data or database to the Model being used in the application
/// It's helpful in case the data source changes we can update the mapping here and not need to change it in all other locations, just the mapping section
struct RestaurantProfileDataMapperHelper {
    // Access the managed stored data object
    let moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
    }
    
    // TODO: Add loading of the normal RestaurantModel object for display purposes for users and not the logged in restaurant
    
    // add new Restaurant to the stored data
    // only a logged in user can add their restaurant to the store and edit their restaurant data
    // The venueId and the profileModel userId are the same and that's how they can verufy each other
    
    /// Adds the restaurant peofile to the store
    /// - Parameters:
    ///   - restaurantProfileModel: populated restaurant data from front end
    ///   - userId: unique user ID provided by Firebase auth on login and account creation
    func addNewRestaurantToStore(restaurantProfileModel: RestaurantProfileModel, userId: String) {

        if (!userId.isEmpty) {
            let newRestaurant = Restaurant(context: moc)
            newRestaurant.id = UUID()
            newRestaurant.venueId = userId
            newRestaurant.name = restaurantProfileModel.name
            newRestaurant.slug = restaurantProfileModel.slug
            newRestaurant.phone = restaurantProfileModel.phone
            newRestaurant.websiteUrl = restaurantProfileModel.websiteUrl
            newRestaurant.menuUrl = restaurantProfileModel.menuUrl
            newRestaurant.cuisine = restaurantProfileModel.cuisine
            newRestaurant.image = restaurantProfileModel.image
            newRestaurant.fullAddressString = restaurantProfileModel.fullAddressString
            newRestaurant.latitude = restaurantProfileModel.latitude
            newRestaurant.longitude = restaurantProfileModel.longitude
            newRestaurant.businessRegoNumber = restaurantProfileModel.businessRegoNumber
            newRestaurant.validationCode = restaurantProfileModel.validationCode

            newRestaurant.numOfQueue = "0"
            newRestaurant.inQueue = ""
            newRestaurant.mainImage = restaurantProfileModel.mainImage
            newRestaurant.subImage1 = restaurantProfileModel.subImage1
            newRestaurant.subImage2 = restaurantProfileModel.subImage2
            newRestaurant.subImage3 = restaurantProfileModel.subImage3
            newRestaurant.subImage4 = restaurantProfileModel.subImage4

            
            try? self.moc.save()
        }
    }
    
    // Map the stored restaurant profile Data to the restaurant profile model
    // TODO: don't like these long names, make them smaller and still meaningful.... just long now to make sure keep track of functionality
    /// Maps the stored core data object to the front end used restaurant profile model
    /// - Parameters:
    ///   - restaurantProfileModel: profile model provided from front end to be populated
    ///   - restaurantDataModel: restaurant data stored in core data
    func mapCoreDataStoredRestaurantProfileDataToRestaurantProfileModel(restaurantProfileModel: RestaurantProfileModel, restaurantDataModel: Restaurant) {
        restaurantProfileModel.id = restaurantDataModel.id
        restaurantProfileModel.venueId = restaurantDataModel.venueId
        restaurantProfileModel.name = restaurantDataModel.name
        restaurantProfileModel.slug = restaurantDataModel.slug
        restaurantProfileModel.phone = restaurantDataModel.phone
        restaurantProfileModel.websiteUrl = restaurantDataModel.websiteUrl
        restaurantProfileModel.menuUrl = restaurantDataModel.menuUrl
        restaurantProfileModel.cuisine = restaurantDataModel.cuisine
        restaurantProfileModel.image = restaurantDataModel.image
        restaurantProfileModel.fullAddressString = restaurantDataModel.fullAddressString
        restaurantProfileModel.latitude = restaurantDataModel.latitude
        restaurantProfileModel.longitude = restaurantDataModel.longitude
        restaurantProfileModel.businessRegoNumber = restaurantDataModel.businessRegoNumber
        restaurantProfileModel.validationCode = restaurantDataModel.validationCode
        restaurantProfileModel.inQueue = restaurantDataModel.inQueue
        restaurantProfileModel.mainImage = restaurantDataModel.mainImage
        restaurantProfileModel.subImage1 = restaurantDataModel.subImage1
        restaurantProfileModel.subImage2 = restaurantDataModel.subImage2
        restaurantProfileModel.subImage3 = restaurantDataModel.subImage3
        restaurantProfileModel.subImage4 = restaurantDataModel.subImage4
        restaurantProfileModel.numOfQueue = restaurantDataModel.numOfQueue
        restaurantProfileModel.inQueue = restaurantDataModel.inQueue
    }
    
    // Update Restaurant by restaurant ID when editing profile data
    /// Updates the restaurant details in core data store by venueID
    /// - Parameter restaurantProfileModel: the populated restaurant model from the front end
    func updateRestaurantByVenueId(restaurantProfileModel: RestaurantProfileModel) {
        if (!restaurantProfileModel.venueId.isEmpty) {
            var restaurantData = getStoredRestaurantByVenueId(venueId: restaurantProfileModel.venueId, in: self.moc)
            
            if (restaurantData != nil) {
                restaurantData?.name = restaurantProfileModel.name
                restaurantData?.slug = restaurantProfileModel.slug
                restaurantData?.phone = restaurantProfileModel.phone
                restaurantData?.websiteUrl = restaurantProfileModel.websiteUrl
                restaurantData?.image = restaurantProfileModel.image
                restaurantData?.fullAddressString = restaurantProfileModel.fullAddressString
                restaurantData?.latitude = restaurantProfileModel.latitude
                restaurantData?.longitude = restaurantProfileModel.longitude
                restaurantData?.businessRegoNumber = restaurantProfileModel.businessRegoNumber
                restaurantData?.validationCode = restaurantProfileModel.validationCode
                
                restaurantData?.mainImage = restaurantProfileModel.mainImage
                restaurantData?.subImage1 = restaurantProfileModel.subImage1
                restaurantData?.subImage2 = restaurantProfileModel.subImage2
                restaurantData?.subImage3 = restaurantProfileModel.subImage3
                restaurantData?.subImage4 = restaurantProfileModel.subImage4
                try? self.moc.save()
            }
        }
    }
    
    /// The restaurant should able to change thier validation code, and this function allows restaurant can change their validation code
    /// - Parameter restaurantProfileModel: When the restaurant profile model which includes new validation code, the real restaurant data will be copied with this model
    func updateRestaurantValidationCode(restaurantProfileModel: RestaurantProfileModel) {
        if (!restaurantProfileModel.venueId.isEmpty) {
            var restaurantData = getStoredRestaurantByVenueId(venueId: restaurantProfileModel.venueId, in: self.moc)
            
            if (restaurantData != nil) {
                restaurantData?.name = restaurantProfileModel.name
                restaurantData?.slug = restaurantProfileModel.slug
                restaurantData?.phone = restaurantProfileModel.phone
                restaurantData?.websiteUrl = restaurantProfileModel.websiteUrl
                restaurantData?.image = restaurantProfileModel.image
                restaurantData?.fullAddressString = restaurantProfileModel.fullAddressString
                restaurantData?.latitude = restaurantProfileModel.latitude
                restaurantData?.longitude = restaurantProfileModel.longitude
                restaurantData?.businessRegoNumber = restaurantProfileModel.businessRegoNumber
                restaurantData?.validationCode = restaurantProfileModel.validationCode
                
                try? self.moc.save()
            }
        }
    }
    
    // Get a restaurant profile model from the stored core data by venueId
    /// Gets a restaurant stored data from core data by venue id
    /// - Parameters:
    ///   - venueId: the unique venue ID provied by firebase auth login/creation - venueId matches the customer ID of the created restaurant profile
    ///   - context: Core Data context to access it's instance
    /// - Returns: Restaurant -> the core data Restaurant data model
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
    
    // Get restaurant from store data after login with restaurant profile
    // if it fails return false, if success then update details and return true
    // with this we can check to get a restaurant, if it's not present then create a new one, but if present, update the model
    
    // TODO: make better return responses
    
    /// This method is used for signup/login actions and either loads the restaurant data if it exists already, or creates the restaurant data if it doesn't exist in the core data store
    /// - Parameters:
    ///   - restaurantProfileModel: populated restaurant model from the front end
    ///   - userId: unique userID that will also be the venueId on cration
    /// - Returns: Bool -> True if restaurant exists and loads data, False if restaurant does not exist and data is crated in score data
    func loadOrCreateRestaurantProfileModel(restaurantProfileModel: RestaurantProfileModel, userId: String) -> Bool {
        
        if let fetchedRestaurant = getStoredRestaurantByVenueId(venueId: userId, in: self.moc) {
            // update the restaurant model here as there is one that exists already
            mapCoreDataStoredRestaurantProfileDataToRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, restaurantDataModel: fetchedRestaurant)
            
            return true
        } else {
            // restaurant couldn't be found so we create a new one
            addNewRestaurantToStore(restaurantProfileModel: restaurantProfileModel, userId: userId)
            return false
        }
    }
    
    // Just load data for restaurant to the mode
    // TODO: better return values need to be applied
    /// Loads the restaurant profile to an empty restaurantProfile model
    /// - Parameters:
    ///   - restaurantProfileModel: usually an empty profile model that is used to load data to
    ///   - userId: unique userID which is the same as the venueid for the restaurant
    /// - Returns: Bool -> True if restaurant is loaded, False if it doesn't exist
    func loadRestaurantProfileModel(restaurantProfileModel: RestaurantProfileModel, userId: String) -> Bool {
        
        if let fetchedRestaurant = getStoredRestaurantByVenueId(venueId: userId, in: self.moc) {
            // update the restaurant model here as there is one that exists already
            mapCoreDataStoredRestaurantProfileDataToRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, restaurantDataModel: fetchedRestaurant)
            
            return true
        } else {
            // no data found, need to do better logging
            // TODO: update logging here
            return false
        }
    }
    
    /// When the restaurant accept a team or kick a team, the queue must be refreshed.
    /// - Parameters:
    ///   - restaurantProfileModel: the restauratn where the queue will be refreshed
    ///   - refreshedQueue: refreshed queue
    ///   - newNumOfQueue: when queue is refreshed, the number of waiting team is also needed to be decreased
    func refreshTheQueue(restaurantProfileModel: RestaurantProfileModel, refreshedQueue: String, newNumOfQueue: String){
        if (!restaurantProfileModel.venueId.isEmpty) {
            var restaurantData = getStoredRestaurantByVenueId(venueId: restaurantProfileModel.venueId, in: self.moc)
            
            if (restaurantData != nil) {
                restaurantData?.name = restaurantProfileModel.name
                restaurantData?.slug = restaurantProfileModel.slug
                restaurantData?.phone = restaurantProfileModel.phone
                restaurantData?.websiteUrl = restaurantProfileModel.websiteUrl
                restaurantData?.image = restaurantProfileModel.image
                restaurantData?.fullAddressString = restaurantProfileModel.fullAddressString
                restaurantData?.latitude = restaurantProfileModel.latitude
                restaurantData?.longitude = restaurantProfileModel.longitude
                restaurantData?.businessRegoNumber = restaurantProfileModel.businessRegoNumber
                restaurantData?.validationCode = restaurantProfileModel.validationCode
                restaurantData?.inQueue = refreshedQueue
                restaurantData?.numOfQueue = newNumOfQueue
                try? self.moc.save()
            }
        }
    }
}
