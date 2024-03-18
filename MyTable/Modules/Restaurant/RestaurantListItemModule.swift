//
//  Restaurant.swift
//  MyTable
//
//  Created by Pascal Couturier on 20/8/2023.
//

import SwiftUI

// Module that lsist all the specific restaurant details for a single restaurant
// when used within a list
/// Restaurant item list, displays restaurant details when in a list
struct RestaurantListItemModule: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        HStack {
            
            if let data = restaurant.image, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 150, height: 100)
                    .cornerRadius(5)
                    .padding(.leading, 10)
            }else{
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(5)
                    .padding(.leading, 10)
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
                .padding(.top, 5)
                
                Spacer()
                
                VStack{
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
                }
                .padding(.bottom, 5)
            }
            .padding(.leading,  20)
        }
    }
}
