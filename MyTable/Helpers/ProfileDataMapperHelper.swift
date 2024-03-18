//
//  ProfileDataMapperHelper.swift
//  MyTable
//
//  Created by Pascal Couturier on 27/9/2023.
//
// This Helper is to help map between the profileModel and the customer and restaurant data models for whicher user is logged in

import Foundation
import CoreData

/// Helper to assist with mapping data from stored information i.e. Core Data or database to the Model being used in the application
/// It's helpful in case the data source changes we can update the mapping here and not need to change it in all other locations, just the mapping section
struct ProfileDataMapperHelper {
    // Access the managed stored data object
    let moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
    }
    
    // We have user data mapped to stored profile data and add it to store
    /// Adds a new user to the Core Data storage
    /// - Parameters:
    ///   - profileModel: the user profile object
    ///   - uid: The unique ID created for the user and attained from the firebase authentication on account creation or login
    func addNewUserToStore(profileModel: ProfileModel, uid: String?) {
        if (uid != nil) {
            let newUser = Customer(context: moc)
            newUser.id = UUID()
            newUser.firstname = profileModel.firstName
            newUser.lastname = profileModel.lastName
            newUser.password = profileModel.password
            newUser.phone = profileModel.phone
            newUser.userId = uid!
            newUser.username = profileModel.username
            newUser.email = profileModel.email
            newUser.isVenue = profileModel.isVenue
            newUser.inQueue = profileModel.inQueue
            newUser.teamNumber = profileModel.teamNumber
            try? self.moc.save()
        }
    }
    
    // Map the stored user data to the profile model when retieveing it from the database
    // Profile model is a ObservedObject so it should update everywhere when changed and not need a return
    /// Maps the customer data that is store in Core Data to the user profile that is displayed and used within the application
    /// - Parameters:
    ///   - profileModel: the user profile object from the front end
    ///   - customerDataModel: user data stored within the Core Data storage
    func mapCoreDataStoredUserToProfileModel(profileModel: ProfileModel, customerDataModel: Customer) {
        profileModel.id = customerDataModel.id
        profileModel.userId = customerDataModel.userId
        profileModel.firstName = customerDataModel.firstname
        profileModel.lastName = customerDataModel.lastname
        profileModel.password = customerDataModel.password
        profileModel.phone = customerDataModel.phone
        profileModel.username = customerDataModel.username
        profileModel.email = customerDataModel.email
        profileModel.isVenue = customerDataModel.isVenue
        profileModel.avatar = customerDataModel.avatar
        profileModel.inQueue = customerDataModel.inQueue
        profileModel.teamNumber = customerDataModel.teamNumber
    }
    
    func acceptFromRestaurant(userId: String){
        var customerData = getStoredCustomerByUserId(userId: userId, in: self.moc)
        if (customerData != nil) {
            
            customerData?.inQueue = false
            customerData?.teamNumber = ""
            
            try? self.moc.save()
        }
    }
    
    func leaveFromQueue(profileModel: ProfileModel){
        if (!profileModel.userId.isEmpty) {
            var customerData = getStoredCustomerByUserId(userId: profileModel.userId, in: self.moc)
            if (customerData != nil) {
                customerData?.firstname = profileModel.firstName
                customerData?.lastname = profileModel.lastName
                customerData?.password = profileModel.password
                customerData?.phone = profileModel.phone
                customerData?.username = profileModel.username
                customerData?.email = profileModel.email
                customerData?.isVenue = profileModel.isVenue
                customerData?.avatar = profileModel.avatar
                customerData?.inQueue = false
                customerData?.teamNumber = ""
                
                try? self.moc.save()
            }
        }
    }
    
    /// This function allows user to join in the queue after when their validation code is matched
    /// - Parameters:
    ///   - profileModel: the user who will join in the queue profile model
    ///   - teamnumber: their team number in the queue
    func joinInQueue(profileModel: ProfileModel, teamnumber: String){
        if (!profileModel.userId.isEmpty) {
            var customerData = getStoredCustomerByUserId(userId: profileModel.userId, in: self.moc)
            
            if (customerData != nil) {
                customerData?.firstname = profileModel.firstName
                customerData?.lastname = profileModel.lastName
                customerData?.password = profileModel.password
                customerData?.phone = profileModel.phone
                customerData?.username = profileModel.username
                customerData?.email = profileModel.email
                customerData?.isVenue = profileModel.isVenue
                customerData?.avatar = profileModel.avatar
                customerData?.inQueue = profileModel.inQueue
                customerData?.inQueue = true
                customerData?.teamNumber = teamnumber
                try? self.moc.save()
            }
        }
    }
    
    
    func findUserByID(userID: String, in context: NSManagedObjectContext)-> Customer?{
        
        if(!userID.isEmpty){
            let customerData = getStoredCustomerByUserId(userId: userID, in: self.moc)
           
            return customerData
        }
        
        return nil
        
    }
    
    
    
    // Get a user profile from the coreData, if not present return nil
    // this is using the `userId` that is stored and is the same ID from the Firebase generated UID
    /// Gets the stored customer data from Core Data base on the unique user Id
    /// - Parameters:
    ///   - userId: Unique user id attained from firebase auth login
    ///   - context: the context of the managed object so we can access the Core Data store
    /// - Returns: The Customer object from the Core Data Store
    func getStoredCustomerByUserId(userId: String?, in context: NSManagedObjectContext) -> Customer? {
        if (userId != nil) {
            let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest() as! NSFetchRequest<Customer>
            fetchRequest.predicate = NSPredicate(format: "userId == %@", userId!)
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
    
    // When editing the profile data we want to update it in the database as well
    // this updates it there on edit profile for customer
    /// Updates the user data in the Core Data store using the provided user profile from the front end
    /// - Parameter profileModel: The front end user profile data
    func updateCustomerByUserId(profileModel: ProfileModel) {
        if (!profileModel.userId.isEmpty) {
            var customerData = getStoredCustomerByUserId(userId: profileModel.userId, in: self.moc)
            
            if (customerData != nil) {
                customerData?.firstname = profileModel.firstName
                customerData?.lastname = profileModel.lastName
                customerData?.password = profileModel.password
                customerData?.phone = profileModel.phone
                customerData?.username = profileModel.username
                customerData?.email = profileModel.email
                customerData?.isVenue = profileModel.isVenue
                customerData?.avatar = profileModel.avatar
                customerData?.inQueue = profileModel.inQueue
                
                try? self.moc.save()
            }
        }
    }
    
    // Login functionality to retrieve Stored Core data for specific logged in user
    // Profile model is a ObservedObject so it should update everywhere when changed
    // Return a false value if the user can't be found
    // TODO: update error response to more meaningful error
    /// Loads the user data on successful login with the data that is stored within the store
    /// - Parameters:
    ///   - profileModel: empty user data profile from frontend
    ///   - uid: the unique user ID provided by firebase auth on login
    /// - Returns: Bool -> if there is a user in Core Data storage then returns true, if not returns false
    func loginUserProfile(profileModel: ProfileModel, uid: String) -> Bool {
        if let fetchedUser = getStoredCustomerByUserId(userId: uid, in: self.moc) {
            // update the profileModel with the returned value
            mapCoreDataStoredUserToProfileModel(profileModel: profileModel, customerDataModel: fetchedUser)
            return true
        } else {
            // TODO: do something with the response, maybe more meaningful error message if user can't be found
            return false
        }
    }
    
    // This is the function used to signup a user after successful creation with authentication firebase generation
    // Profile model is a ObservedObject so it should update everywhere when changed and not need a return
    /// On Signup if there is no user by unique ID then it adds the user to the Core data store
    /// - Parameters:
    ///   - profileModel: populated profile data of user from singup form
    ///   - uid: unique user ID provided by Firebase auth on account creation
    /// - Returns: Bool -> True if user doesn't exist and is created in the store - false if the user id already exists in the store
    func signupUserProfileCreation(profileModel: ProfileModel, uid: String) -> Bool {
        
        if let fetchedUser = getStoredCustomerByUserId(userId: uid, in: self.moc) {
            // if it goes here then there is already a user and return false as error and can't create user
            // TODO: do something with the response, maybe more meaningful error message
            return false
        } else {
            // Otherwise if user does not exist, then create them and return true as successfully created
            addNewUserToStore(profileModel: profileModel, uid: uid)
            return true
        }
    }
}

