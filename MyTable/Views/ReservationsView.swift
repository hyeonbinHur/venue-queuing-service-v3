//
//  ReservationsView.swift
//  my_table
//
//  Created by snlcom on 2023/08/14.
//

import SwiftUI

// TODO: update this view so the lists are clickable and the user can view their reservation details on the next page click
/// Reservations view where users can manage and view their reservations
struct ReservationsView: View {
    // Import the restaurant data
    @ObservedObject var bookingsData = LoadBookingsData()
    
    var body: some View {
        
        VStack {
            Text("My Table")
                .font(.title.bold())
            VStack(alignment: .leading, spacing: 12) {
                Text("Reservations")
                    .font(.title2.bold())
                    .padding(EdgeInsets(top: 20, leading: 5, bottom: -5, trailing: 0))
                Group {
                    Text("Upcoming")
                        .font(.headline)
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: -5, trailing: 0))
                    
                    //                 Restaurants list
                    // TODO: Fix this section as when using the restaurant componetn it breaks everything, so copied the code to here
                    List(filterUpcomingReservations(reservations: bookingsData.bookings)) { booking in
                        Text(StringHelper.shared.dateTimeToString(dateTime: StringHelper.shared.stringToDateTime(dateTime: booking.bookingTime)))
                        HStack {
                            Image(booking.image)
                                .resizable()
                                .frame(width: 150, height: 100)
                                .cornerRadius(5)
                            
                            VStack {
                                VStack {
                                    Text(booking.name)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(booking.cuisine)
                                        .font(.footnote)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .opacity(0.5)
                                    
                                }
                                .padding(.top, 5)
                                
                                Spacer()
                                
                                VStack{
                                    Text("\(String(format: "%.1f", booking.distance)) km")
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack {
                                        Image("star-rating")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(.trailing, -1)
                                        Text("\(String(format: "%.1f", booking.rating))")
                                            .font(.footnote)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, -1)
                                    }
                                    .padding(.top, -10)
                                }
                                .padding(.bottom, 5)
                            }
                            .padding(.leading,  20)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .frame(height: 300)
                }
                Group {
                    Text("Previous")
                        .font(.headline)
                    
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: -5, trailing: 0))
                    
                    //                 Restaurants list
                    // TODO: Fix this section as when using the restaurant componetn it breaks everything, so copied the code to here
                    List(filterPreviousReservations(reservations: bookingsData.bookings)) { booking in
                        Group {
                            Text(StringHelper.shared.dateTimeToString(dateTime: StringHelper.shared.stringToDateTime(dateTime: booking.bookingTime)))
                            HStack {
                                Image(booking.image)
                                    .resizable()
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(5)
                                
                                VStack {
                                    VStack {
                                        Text(booking.name)
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(booking.cuisine)
                                            .font(.footnote)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .opacity(0.5)
                                        
                                    }
                                    .padding(.top, 5)
                                    
                                    Spacer()
                                    
                                    VStack{
                                        Text("\(String(format: "%.1f", booking.distance)) km")
                                            .font(.caption)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack {
                                            Image("star-rating")
                                                .resizable()
                                                .frame(width: 10, height: 10)
                                                .padding(.trailing, -1)
                                            Text("\(String(format: "%.1f", booking.rating))")
                                                .font(.footnote)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading, -1)
                                        }
                                        .padding(.top, -10)
                                    }
                                    .padding(.bottom, 5)
                                }
                                .padding(.leading,  20)
                            }
                        }
                        .opacity(0.5)
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
            Spacer()
        }
    }
    
    // this returns the restaurants that are displayed in upcoming
    // as their booking date is future dated
    /// Goes through and filters all reservations that are after todays date
    /// - Parameter reservations: `[ReservationModel]` array of reservations
    /// - Returns: `[ReservationModel]` and array of filtered reservations
    func filterUpcomingReservations(reservations: [ReservationModel]) -> [ReservationModel] {
        var filteredList: [ReservationModel] = []
        
        if (reservations.count > 0) {
            for (reservation) in reservations {
                if(StringHelper.shared.stringToDateTime(dateTime: reservation.bookingTime) > Date()) {
                    filteredList.append(reservation)
                }
            }
        }
        
        return filteredList
    }
    
    // This shows all previous bookings as their booking date is prior to today's date
    /// Goes through and filters all reservations that are prior to todays date
    /// - Parameter reservations: `[ReservationModel]` array of reservations
    /// - Returns: `[ReservationModel]` and array of filtered reservations
    func filterPreviousReservations(reservations: [ReservationModel]) -> [ReservationModel] {
        var filteredList: [ReservationModel] = []
        
        if (reservations.count > 0) {
            for (reservation) in reservations {
                if(StringHelper.shared.stringToDateTime(dateTime: reservation.bookingTime) < Date()) {
                    filteredList.append(reservation)
                }
            }
        }
        
        return filteredList
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView()
    }
}
