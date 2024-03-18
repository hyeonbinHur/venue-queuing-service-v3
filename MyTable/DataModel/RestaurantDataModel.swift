//
//  RestaurantDataModel.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import Foundation
import CoreData

/// The Restaurant data model for Core Data storage used to manage the restaurant details stored
@objc(Restaurant)
public class Restaurant: NSManagedObject{
    @NSManaged public var id: UUID
    @NSManaged public var inQueue: String
    @NSManaged public var menuUrl: String
    @NSManaged public var name: String
    @NSManaged public var numOfQueue: String
    @NSManaged public var phone: String
    @NSManaged public var rating: String
    @NSManaged public var slug: String
    @NSManaged public var venueId: String
    @NSManaged public var websiteUrl: String
    @NSManaged public var cuisine: String
    @NSManaged public var image: String
    @NSManaged public var fullAddressString: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var businessRegoNumber: String
    @NSManaged public var validationCode: String
    
    @NSManaged public var mainImage:Data?
    @NSManaged public var subImage1:Data?
    @NSManaged public var subImage2:Data?
    @NSManaged public var subImage3:Data?
    @NSManaged public var subImage4:Data?

}

extension Restaurant: Identifiable{
    
}

