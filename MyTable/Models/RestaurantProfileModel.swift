//
//  RestaurantProfileModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 2/10/2023.
//

import Foundation

// This class is being used to map the full restaurant data for the logged in venue as the venue will have some extra more specific details than the
// normal restaurant class such as queue management and those details to edit
// TODO: incorporate the `RestaurantModel` into this instead of having duplicate values between them
/// Restaurant profile data, this is where the restaurant owner can manage the restaurant details, as some controls and settings are here that should not be displayed to users which is why it is slightly different to the RestaurantModel
class RestaurantProfileModel: ObservableObject {
    
    @Published var id = UUID()
    @Published var venueId: String
    @Published var name: String
    @Published var slug: String
    @Published var cuisine: String
    @Published var image: String
    @Published var rating: Double
    @Published var phone: String
    @Published var websiteUrl: String
    @Published var menuUrl: String
    @Published var featuredImages: [String]
    @Published var fullAddressString: String
    @Published var latitude : Double
    @Published var longitude : Double
    @Published var numOfQueue : String
    @Published var inQueue : String
    @Published var businessRegoNumber: String
    @Published var validationCode: String
    
    @Published var mainImage: Data?
    @Published var subImage1: Data?
    @Published var subImage2: Data?
    @Published var subImage3: Data?
    @Published var subImage4: Data?
    
    
    init(venueId: String, name: String, slug: String, cuisine: String, image: String, rating: Double, phone: String, websiteUrl: String, menuUrl: String, featuredImages: [String], fullAddressString: String, latitude: Double, longitude: Double, numOfQueue: String, inQueue: String, businessRegoNumber: String, validationCode: String, mainImage: Data?, subImage1: Data?,subImage2: Data?,subImage3: Data?,subImage4: Data?) {
        self.venueId = venueId
        self.name = name
        self.slug = slug
        self.cuisine = cuisine
        self.image = image
        self.rating = rating
        self.phone = phone
        self.websiteUrl = websiteUrl
        self.menuUrl = menuUrl
        self.featuredImages = featuredImages
        self.fullAddressString = fullAddressString
        self.latitude = latitude
        self.longitude = longitude
        self.numOfQueue = numOfQueue
        self.inQueue = inQueue
        self.businessRegoNumber = businessRegoNumber
        self.validationCode = validationCode
        self.mainImage = mainImage
        self.subImage1 = subImage1
        self.subImage2 = subImage2
        self.subImage3 = subImage3
        self.subImage4 = subImage4
    }
    
    convenience init() {
        self.init(venueId: "", name: "", slug: "", cuisine: "", image: "", rating: 0.0, phone: "", websiteUrl: "", menuUrl: "", featuredImages: [], fullAddressString: "", latitude: 0.0, longitude: 0.0, numOfQueue: "", inQueue: "", businessRegoNumber: "", validationCode: "", mainImage: nil, subImage1: nil, subImage2: nil, subImage3: nil,subImage4: nil)
    }
    
    func clearRestaurantProfileData() {
        venueId = ""
        name = ""
        slug = ""
        cuisine = ""
        image = ""
        rating = 0.0
        phone = ""
        websiteUrl = ""
        menuUrl = ""
        featuredImages = []
        fullAddressString = ""
        latitude = 0.0
        longitude = 0.0
        numOfQueue = ""
        inQueue = ""
        businessRegoNumber = ""
        validationCode = ""
        mainImage = nil
        subImage1 = nil
        subImage2 = nil
        subImage3 = nil
        subImage4 = nil
    }
}
