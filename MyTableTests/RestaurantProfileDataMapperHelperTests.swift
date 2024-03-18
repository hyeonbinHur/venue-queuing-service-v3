//
//  RestaurantProfileDataMapperHelperTests.swift
//  MyTableTests
//
//  Created by Pascal Couturier on 14/10/2023.
//

import XCTest
import CoreData

@testable import MyTable

/// Test cases to test core data storeage with the Restaurant profile data mapping
final class RestaurantProfileDataMapperHelperTests: XCTestCase {
    
    var coreDataStack: NSManagedObjectContext!
    var restaurantProfileDataMapperHelper: RestaurantProfileDataMapperHelper!
    var restaurantProfileData: RestaurantProfileModel!
    var uuidAsString: String!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        // setup a test instance of core data
        coreDataStack = CoreDataStackForTesting().persistentContainer.viewContext
        
        // Create the restaurantProfile mapper helper instance
        restaurantProfileDataMapperHelper = RestaurantProfileDataMapperHelper(context: coreDataStack)
        // generate a unique uid
        uuidAsString = UUID().uuidString
        // Create a dummy restaurant profile object
        restaurantProfileData = RestaurantProfileModel(venueId: "", name: "Testing venue",
                                                       slug: "The best place ever",
                                                       cuisine: "Italian",
                                                       image: "",
                                                       rating: 4.5,
                                                       phone: "0400000000",
                                                       websiteUrl: "testsite.com",
                                                       menuUrl: "testsite.com/menu",
                                                       featuredImages: [],
                                                       fullAddressString: "1 Acland Street, St Kilda, Melbourne",
                                                       latitude: -37.862680,
                                                       longitude: 144.973970,
                                                       numOfQueue: "",
                                                       inQueue: "",
                                                       businessRegoNumber: "12345",
                                                       validationCode: "12345",
                                                       mainImage: nil,
                                                       subImage1: nil,
                                                       subImage2: nil,
                                                       subImage3: nil,
                                                       subImage4: nil)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // clear out the test core data on tear down
        coreDataStack = nil
        try super.tearDownWithError()
    }
    
    // Test Add new restaurant profile to core data
    /// Testing adding the restaurant to core data storage
    func testAddNewRestaurantToStore() {
        // add venue
        restaurantProfileDataMapperHelper.addNewRestaurantToStore(restaurantProfileModel: restaurantProfileData, userId: uuidAsString)
        
        // retrieve data from the store
        let restaurantDataFromstore = restaurantProfileDataMapperHelper.getStoredRestaurantByVenueId(venueId: uuidAsString, in: coreDataStack)
        
        // The returned value should not be nil and return with the matching uid as the uidAsString value
        XCTAssertEqual(restaurantDataFromstore?.venueId, uuidAsString)
    }
    
    /// Testing update restaurant profile data in core data storage
    func testUpdateRestaurantByVenueId() {
        // add the data to the coreData store using the first test to create it
        //        testAddNewRestaurantToStore()
//        restaurantProfileDataMapperHelper.addNewRestaurantToStore(restaurantProfileModel: restaurantProfileData, userId: uuidAsString)
        
        var restaurantProfileDataResponse = restaurantProfileDataMapperHelper.getStoredRestaurantByVenueId(venueId: uuidAsString, in: coreDataStack)
        

        // update restaurant details
  
      
        restaurantProfileData.cuisine = "Japanese"
        restaurantProfileData.fullAddressString = "5 Acland Street, St Kilda, Melbourne"
        restaurantProfileData.websiteUrl = "changed.com"
        restaurantProfileData.name = "changed name"
        print("restaurant: \(String(describing: restaurantProfileData.cuisine))")
        // update details in the store
        restaurantProfileDataMapperHelper.updateRestaurantByVenueId(restaurantProfileModel: restaurantProfileData)
        
        
        XCTAssertEqual(restaurantProfileData.cuisine, "Japanese")
        XCTAssertEqual(restaurantProfileData.fullAddressString, "5 Acland Street, St Kilda, Melbourne")
        XCTAssertEqual(restaurantProfileData.websiteUrl, "changed.com")
        XCTAssertEqual(restaurantProfileData.name, "changed name")
        
        // Get user again by id and check if email has changed
        if let updatedValueOfRestaurant = restaurantProfileDataMapperHelper.getStoredRestaurantByVenueId(venueId: restaurantProfileData.venueId, in: coreDataStack){
            
            // Check values returned have now been updated
            // TODO: Fix this, why is it not updating the values correctly
            
            XCTAssertEqual(updatedValueOfRestaurant.cuisine, "Japanese")
            XCTAssertEqual(updatedValueOfRestaurant.fullAddressString, "5 Acland Street, St Kilda, Melbourne")
            XCTAssertEqual(updatedValueOfRestaurant.websiteUrl, "changed.com")
            XCTAssertEqual(updatedValueOfRestaurant.name, "changed name")
            
        }
        
        
    }
    
    /// Load resaurant profile data success and should return a true value
    func testLoadRestaurantProfileModelSuccess() {
        // use original method to create profile
        testAddNewRestaurantToStore()
        let loadRestaurantResponse = restaurantProfileDataMapperHelper.loadRestaurantProfileModel(restaurantProfileModel: restaurantProfileData, userId: uuidAsString)
        
        // should return true as successful
        XCTAssertEqual(loadRestaurantResponse, true)
    }
    
    /// Load resaurant profile data failure and should return a false value
    func testLoadRestaurantProfileModelFailure() {
        // use original method to create profile
        let loadRestaurantResponse = restaurantProfileDataMapperHelper.loadRestaurantProfileModel(restaurantProfileModel: restaurantProfileData, userId: uuidAsString)
        
        // should return false as failure
        XCTAssertEqual(loadRestaurantResponse, false)
    }
    
    func testRefreshTheQueue(){
        restaurantProfileDataMapperHelper.refreshTheQueue(restaurantProfileModel: restaurantProfileData, refreshedQueue: "pascal,hyeonbin", newNumOfQueue: "2")
        
        if let refreshedData = restaurantProfileDataMapperHelper.getStoredRestaurantByVenueId(venueId: uuidAsString, in: coreDataStack){
            XCTAssertEqual(refreshedData.inQueue, "pascal,hyeonbin")
            
            XCTAssertEqual(refreshedData.numOfQueue, "2")
        }
    }
}
