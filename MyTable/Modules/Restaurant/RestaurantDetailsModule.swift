//
//  RestaurantDetailsModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 25/8/2023.
//

import Foundation
import SwiftUI

// Details module which has high level details of the restairant and used on the main restaurant page
// for users
/// Restaurant details module, displays the restaurant data passed in
struct RestaurantDetailsModule: View {
    
    @Binding var restaurant: RestaurantModel
    
    var body: some View {
        HStack {
            if let data = restaurant.mainImage, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 150, height: 100)
                    .cornerRadius(5)
                    .padding(.leading, 30)
            }else{
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(5)
            }
            VStack {
                VStack {
                    Text(restaurant.name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(restaurant.cuisine)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(0.5)
                }
                .padding(.leading, 20)
                
                VStack {
                    Text("\(String(format: "%.1f", restaurant.distance)) km")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image("star-rating")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(.trailing, -1)
                        Text("\(String(format: "%.1f", restaurant.rating))")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -1)
                    }
                    .padding(.top, -10)
                    
                    HStack {
                        Image(systemName: "phone")
                        Link("\(restaurant.phone)", destination: URL(string: "tel:\(self.filterWhitespace(value: restaurant.phone))")!)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
            }
            Spacer()
        }
        VStack {
            HStack {
                Image(systemName: "globe")
                Link("\(restaurant.websiteUrl)", destination: (URL(string: restaurant.websiteUrl)!))
                    .font(.footnote)
                Spacer()
            }
            HStack {
                Image(systemName: "menucard")
                Link("View the menu", destination: (URL(string: restaurant.menuUrl)!))
                    .font(.footnote)
                Link(destination: (URL(string: restaurant.menuUrl)!)) {
                    Image(systemName: "chevron.right")
                }
                Spacer()
            }
            .padding(.top, 1)
            
            // TODO: make this into a dropdown stack with hours from data
            HStack {
                Image(systemName: "clock")
                Text("Wednesday 12:00 pm - 10:00 pm")
                    .font(.footnote)
                Image(systemName: "chevron.down.circle")
                    .foregroundColor(Color.blue)
                Spacer()
            }
            .padding(.top, 1)
        }
        .padding(.leading, 30)
        .padding(.top, 2)
    }
    
    // Using this so that the contact number is clickable as a tel: link
    // TODO: make into a global helper
    func filterWhitespace(value: String) -> String {
        return value.filter {!$0.isWhitespace}
    }
}
