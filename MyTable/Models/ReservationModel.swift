//
//  ReservationModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 21/8/2023.
//

import Foundation

// Model for all reservations when making bookings
/// Reservation model that handles the reservation data to display to users
struct ReservationModel: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case venueId
        case name
        case slug
        case cuisine
        case image
        case distance
        case rating
        case latitude
        case longitude
        case bookingTime
        case userId
    }
    
    var id = UUID()
    var venueId: String
    var name: String
    var slug: String
    var cuisine: String
    var image: String
    var distance: Double
    var rating: Double
    var latitude : Double
    var longitude : Double
    var bookingTime: String
    var userId: String
}

/// Load the booking data from json dummy data
class LoadBookingsData: ObservableObject {
    @Published var bookings = [ReservationModel]()
    
    init() {
        loadBookings()
    }
    
    // TODO: This currently load dummy data from a json file
    /// Loads dummy bookings
    func loadBookings() {
        guard let url = Bundle.main.url(forResource: "BookingData", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        let data = try? Data(contentsOf: url)
        let bookings = try? JSONDecoder().decode([ReservationModel].self, from: data!)
        self.bookings = bookings!
    }
}
