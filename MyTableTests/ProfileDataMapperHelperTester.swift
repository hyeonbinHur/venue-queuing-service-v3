//
//  ProfileDataMapperHelperTester.swift
//  MyTableTests
//
//  Created by Pascal Couturier on 14/10/2023.
//

import XCTest
import CoreData

@testable import MyTable

/// Testing the core Data storage methods with the profile data mapper
class ProfileDataMapperHelperTester: XCTestCase {
    
    var userData: ProfileModel!
    var coreDataStack: NSManagedObjectContext!
    var uuidAsString: String!
    var profileMapperHelper: ProfileDataMapperHelper!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        // Setup test userdata
        userData = ProfileModel(userId: "", firstName: "FirstName", lastName: "LastName", password: "password", username: "tester", email: "tester@tester.com", phone: "0400000000", avatarUrl: "", isVenue: false, avatar: nil, selectedImage: nil, inQueue: false, teamNumber: "")
        // setup a test instance of core data
        coreDataStack = CoreDataStackForTesting().persistentContainer.viewContext
        
        uuidAsString = UUID().uuidString
        profileMapperHelper = ProfileDataMapperHelper(context: coreDataStack)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // clear out the test core data on tear down
        coreDataStack = nil
        try super.tearDownWithError()
    }
    
    // Test creating a profile user in the database
    /// testing adding a new user to core data storage
    func testAddNewUserToStore() {
        // use the created core data
        
        // add the data to the coreData store
        profileMapperHelper.addNewUserToStore(profileModel: userData, uid: uuidAsString)
        
        // Retrieve the data from the store
        let profileMapperResult = profileMapperHelper.getStoredCustomerByUserId(userId: uuidAsString, in: coreDataStack)
        
        // The retrieved data should have a userId that matches the string
        XCTAssertEqual(profileMapperResult?.userId, uuidAsString)
    }
    
    // Test updating the user in the core data store
    /// Testing update user data in core data storage
    func testUpdateCustomerByUserId() {
        // add the data to the coreData store
        profileMapperHelper.addNewUserToStore(profileModel: userData, uid: uuidAsString)
        
        let profileMapperResult = profileMapperHelper.getStoredCustomerByUserId(userId: uuidAsString, in: coreDataStack)
        XCTAssertEqual(profileMapperResult?.email, "tester@tester.com")
        
        // update email to check it gets updated by the method
        userData?.email = "changed@changed.com"
        userData.userId = profileMapperResult!.userId
        // update details in the store
        profileMapperHelper.updateCustomerByUserId(profileModel: userData)
        
        // Get user again by id and check if email has changed
        let updatedValueOfUser = profileMapperHelper.getStoredCustomerByUserId(userId: uuidAsString, in: coreDataStack)
        // email should have updated and changed
        XCTAssertEqual(updatedValueOfUser?.email, "changed@changed.com")
    }
    
    // test loading the profile user
    /// Testing the user login and loading the profile data, should be a successful login and return true
    func testLoginUserProfileSuccess() {
        // should return with true if successful
        // use previous test to create the user
        testAddNewUserToStore()
        let loadUserDataResponse = profileMapperHelper.loginUserProfile(profileModel: userData, uid: uuidAsString)
        
        XCTAssertEqual(loadUserDataResponse, true)
    }
    
    /// Testing the user login and loading the profile data, should be a failed load and return false
    func testLoginUserProfileFailure() {
        // changing the uid to one that doesn't exist so shouldn't return success 
        let loadUserDataResponse = profileMapperHelper.loginUserProfile(profileModel: userData, uid: "1")
        
        XCTAssertEqual(loadUserDataResponse, false)
    }
    
    /// testing to see if the user is created and stored in the core data storage, should return true if user is created
    func testSignupUserProfileCreationSuccess() {
        let signupUserProfileCreationResponse = profileMapperHelper.signupUserProfileCreation(profileModel: userData, uid: uuidAsString)
        // Should return true as user ID should not be found existing in the database already
        XCTAssertEqual(signupUserProfileCreationResponse, true)
    }
    
    /// testing to see if the user is created and stored in the core data storage, should return false if user is not created
    func testSignupUserProfileCreationFailure() {
        // use previous method to add user to the database
        testAddNewUserToStore()
        // get user from database
        let signupUserProfileCreationResponse = profileMapperHelper.signupUserProfileCreation(profileModel: userData, uid: uuidAsString)
        // Should return false as user ID should be found existing in the database already and not newly created
        XCTAssertEqual(signupUserProfileCreationResponse, false)
    }
    
    func testJoinInterQueue(){
        
        profileMapperHelper.joinInQueue(profileModel: userData, teamnumber: "3")
        // when an user join in the queue, there status of in queue will be changed to ture, and corresponding team number should be given
        if let profileMapperResult = profileMapperHelper.findUserByID(userID: uuidAsString, in: coreDataStack){
            XCTAssertEqual(profileMapperResult.teamNumber, "3")
            
            XCTAssertEqual(profileMapperResult.inQueue, true)
        }
        
        
        
    }
    
    func testleaveQueue(){
        profileMapperHelper.leaveFromQueue(profileModel: userData)
        //when an user leave from the queue, their status must be changed to false, their team number must be empty
        if let profileMapperResult = profileMapperHelper.findUserByID(userID: uuidAsString, in: coreDataStack){
            XCTAssertEqual(profileMapperResult.teamNumber, "")
            
            XCTAssertEqual(profileMapperResult.inQueue, false)
        }
        

    }
    func testArriveRes(){
        profileMapperHelper.acceptFromRestaurant(userId: userData.userId)
        // when an user arrived to the venue, and venue checks thir arrival, the user's in queu status must be change to false, and their team number must be empty
        if let profileMapperResult = profileMapperHelper.findUserByID(userID: uuidAsString, in: coreDataStack){
            XCTAssertEqual(profileMapperResult.teamNumber, "")
            
            XCTAssertEqual(profileMapperResult.inQueue, false)
        }

    }
}
