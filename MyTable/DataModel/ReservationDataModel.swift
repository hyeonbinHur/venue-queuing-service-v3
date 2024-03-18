//
//  ReservationDataModel.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import Foundation
import CoreData

/// Reservation model for the Core Data stored information
@objc(Reservation)
public class Reservation: NSManagedObject{
    @NSManaged public var id: UUID
    @NSManaged public var bookingTime: String
    @NSManaged public var cusine: String
    @NSManaged public var distance: Double
    @NSManaged public var image: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String
    @NSManaged public var rating: Double
    @NSManaged public var slug: String
    @NSManaged public var userId: String
    @NSManaged public var venueId: String
}

extension Reservation: Identifiable{
    
}


