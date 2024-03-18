//
//  Customer.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import Foundation
import CoreData


/// The customer data model for Core Data storage, this is used for the logged in user i.e. the customer or restaurant owner login credentials
@objc(Customer)
public class Customer: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var email: String
    @NSManaged public var firstname: String
    @NSManaged public var lastname: String
    @NSManaged public var password: String
    @NSManaged public var phone: String
    @NSManaged public var userId: String
    @NSManaged public var username: String
    @NSManaged public var isVenue: Bool
    @NSManaged public var avatar: Data?
    @NSManaged public var inQueue: Bool
    @NSManaged public var teamNumber: String
    
}

extension Customer: Identifiable {
}
