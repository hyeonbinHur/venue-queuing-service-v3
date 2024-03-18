//
//  RestaurantInQueueModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 25/8/2023.
//

import Foundation
import SwiftUI

// Module that handles the display of when a user is currently waiting in a queue
// for the specific restaurant
/// Restaurant queue module, allws users to view the queue of a restaurant
struct RestaurantInQueueModule: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var profileModel: ProfileModel
    @Binding var restaurant: RestaurantModel
    
    @Binding var isFeaturedQueueView: Bool
    @Binding var isReservationView: Bool
    @Binding var isCurrentlyInQueue: Bool
    
    // TODO: variables that need to be attached to a model where data is received
    // displaying the active queue count will require websockets and may be
    // to time consuming to implement live integration for this for now
    @Binding var currentQueueCount: String
    @Binding var waitingHour: Int
    @Binding var waitingMin: Int
    
    var body: some View {
        VStack {
            Text("My Table queue")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.top, 20)
            
            Text("Your number:")
                .font(.footnote.bold())
                .padding(.top)
            Text("\(restaurant.numOfQueue)")
                .font(.largeTitle)
            
            Group {
                Text("Details")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.top, 20)
                
                // TODO: create dummy data and add to model
                HStack {
                    Text("Date joined:")
                        .font(.footnote.bold())
                    Text("10/08/2023")
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.top, 2)
                
                // TODO: create dummy data and add to model
                HStack {
                    Text("Time joined:")
                        .font(.footnote.bold())
                    Text("\(waitingHour):\(waitingMin) pm")
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.top, 2)
            }
            
            Spacer()
            
            Button(action:{leaveQueue()
            },label:{Text("Leave queue")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorGrey1")
                    )
                
            })
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
    }
    
    // when leaving the queue the user goes back to the main venue details
    // TODO: remove self from queue with both venue and user
    func leaveQueue() {
        if let IntValue = Int(restaurant.numOfQueue){
            
            let newValue = IntValue-1
            restaurant.numOfQueue = String(newValue)
            RestaurantsMappingHelper(context: moc).updateQueue(restaurant: restaurant,uuid:profileModel.userId)
            
            ProfileDataMapperHelper(context: moc).leaveFromQueue(profileModel: profileModel)
            
        }
        self.isCurrentlyInQueue = false
        self.isReservationView = false
        self.isFeaturedQueueView = true
    }
}
