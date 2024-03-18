//
//  ProfileModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 21/8/2023.
//

import Foundation
import UIKit

/// logged in user Profile data
class ProfileModel: ObservableObject {
    
    @Published var id = UUID()
    @Published var userId: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var password: String
    @Published var username: String
    @Published var email: String
    @Published var phone: String
    @Published var avatarUrl: String
    @Published var isVenue: Bool
    @Published var isLoggedIn: Bool = false
    @Published var selectedImage: UIImage? = UIImage()
    @Published var avatar: Data?
    @Published var inQueue: Bool
    @Published var teamNumber: String
   
    
    init(userId: String, firstName: String, lastName: String, password: String, username: String, email: String, phone: String, avatarUrl: String, isVenue: Bool, avatar: Data?, selectedImage:UIImage?, inQueue: Bool, teamNumber: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.username = username
        self.email = email
        self.phone = phone
        self.avatarUrl = avatarUrl
        self.isVenue = isVenue
        self.avatar = avatar
        self.selectedImage = selectedImage
        self.inQueue = inQueue
        self.teamNumber = teamNumber
    }
    
    // Add your custom initializer here if needed
    convenience init() {
        self.init(userId: "", firstName: "", lastName: "", password: "", username: "", email: "", phone: "", avatarUrl: "", isVenue: false, avatar: nil, selectedImage: nil,inQueue: false, teamNumber: "")
    }
    
    // Implement Codable methods here
    
    // Clears profile data when a user logs out of the application
    func clearProfileData() {
        userId = ""
        firstName = ""
        lastName = ""
        password = ""
        username = ""
        email = ""
        phone = ""
        avatarUrl = ""
        isVenue = false
        isLoggedIn = false
        avatar = nil
        selectedImage = nil
        inQueue = false
        teamNumber = ""
    }
    
    // For testing purposes and Preview only
    func loadDummyCustomerProfileData() {
        userId = UUID().uuidString
        firstName = "First name"
        lastName = "Test surname"
        password = "Password"
        username = "Username"
        email = "email@email.com"
        phone = "0400000000"
        avatarUrl = ""
        isVenue = false
        isLoggedIn = false // setting to false as login after load turns to true - to use in preview set to true after loading data manually
    }
    
    // For testing purposes and Preview only
    func loadDummyVenueProfileData() {
        userId = UUID().uuidString
        firstName = "Venue First name"
        lastName = "Venue Test surname"
        password = "Password"
        username = "Username"
        email = "email@venue.com"
        phone = "0400000000"
        avatarUrl = ""
        isVenue = true
        isLoggedIn = false // setting to false as login after load turns to true - to use in preview set to true after loading data manually
    }
}
