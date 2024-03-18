//
//  RestaurantFeaturedModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 25/8/2023.
//

import Foundation
import SwiftUI

// This displays the venue's featured images across the page
/// Restaurant featured page module, displays the restaurant main content and featured images
struct RestaurantFeaturedModule: View {
    
    @Binding var restaurant: RestaurantModel
    @Binding var isFeaturedQueueView: Bool
    @Binding var isReservationView: Bool
    
    var body: some View {
        // MARK: Featured Section View
        Group {
            // This is the featured image section to display to users
            VStack {
                Text("Featured")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.top, 20)
                
                // Side scrolling first 3 images
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(Array((restaurant.featuredImages?.enumerated())!), id: \.offset) { index, image in
                            if (0...4).contains(index) {
                                Image(uiImage: UIImage(data: image)!)
                                    .resizable()
                                    .frame(width: 300, height: 200)
                                    .cornerRadius(8)
                                    .padding(.leading, 30)
                            }
                        }
                    }
                }
                .padding(.leading, -335)
                .padding(.top, -160)
                
                
            }
            // join the queue button
            Button(action:{requestToJoinQueueView()},label:{Text("Join the queue")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                
            })
            .padding(.top, -60)
            .padding(.bottom, 0)
            
            // Make a reservation button
            Button(action:{ makeReservationView()
            },label:{Text("Make a reservation")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorGrey1")
                    )
                
            })
            .padding(.top, -12)
            .padding(.bottom, 20)
        }
    }
    
    // Transition to the join queue page
    // TODO: add functionality for code send
    func requestToJoinQueueView() {
        self.isFeaturedQueueView = false
        self.isReservationView = false
    }
    
    // Transition to reservation view
    func makeReservationView() {
        self.isFeaturedQueueView = false
        self.isReservationView = true
    }
}

