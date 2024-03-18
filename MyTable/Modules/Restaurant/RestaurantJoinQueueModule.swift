//
//  RestaurantJoinQueueModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 26/8/2023.
//

import Foundation
import SwiftUI

// Module that handles the joining of a restaurant queue
/// Allows users to join a queue for a restaurant
struct RestaurantJoinQueueModule: View {
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
    @Binding var waitingTime: Int
    @Binding var waitingTimePerTeam: Int
    @Binding var waitingHour: Int
    @Binding var waitingMin: Int
    
    @Binding var RestaurantValidationCode: String
    
    @State private var validationCode: String = ""
    @State private var userId: String = ""
  
    var body: some View {
        VStack {
            
            Text("Join the queue")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.top, 20)
            ZStack {
                Circle()
                    .frame(width: 150)
                    .foregroundColor(Color("ColorGrey1"))
                    .padding(.top, 30)
                Text("\(restaurant.numOfQueue)")
                    .font(.largeTitle.bold())
                    .padding(.top, 20)
            }
            
            Text("\(restaurant.numOfQueue) teams in the queue!")
            
            // Validation code input
            // TODO: add send code and validation code functionality
            VStack(alignment: .leading) {
                Text("Validation code")
                    .font(.headline)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: -5, trailing: 0))
                TextField("Validation code", text: $validationCode)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 0)
                Text("Enter the code that was sent to your device")
                    .font(.footnote)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: -5, trailing: 0))
                    .opacity(0.4)
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 30, trailing: 30))
            
            Button(action:{validateCodeAndJoinQueue()},label:{Text("Validate code and join the queue")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                
            })
            .padding(.top, 0)
            
            Button(action:{leaveQueue()
            },label:{Text("Cancel")
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
    
    /// this function check whether entered validation codes are matched
    func validateCodeAndJoinQueue() {
        // TODO: add functionality to validate code and add user to queue and map with restaurant
        
        if RestaurantValidationCode == validationCode {
            
            self.isCurrentlyInQueue = true
            print("1")
            if let IntValue = Int(restaurant.numOfQueue){
                let newValue = IntValue+1
                restaurant.numOfQueue = String(newValue)
                print("2")
                RestaurantsMappingHelper(context: moc).updateQueue(restaurant: restaurant, uuid: profileModel.userId)
                
                ProfileDataMapperHelper(context: moc).joinInQueue(profileModel: profileModel, teamnumber: restaurant.numOfQueue)
                
            }
        }
        waitingTimeCalculation()
    }
    
    // When leaving the queue, goes back to venu details view
    // TODO: remove self from queue with both venue and user
    /// this function allows user to leave the queue
    func leaveQueue() {

        ProfileDataMapperHelper(context: moc).leaveFromQueue(profileModel: profileModel)
        
        self.isCurrentlyInQueue = false
        self.isReservationView = false
        self.isFeaturedQueueView = true
    }
    
    func waitingTimeCalculation(){
        if let n = Int(restaurant.numOfQueue){
            waitingTime = n*waitingTimePerTeam
            waitingHour = waitingTime/60
            waitingMin = waitingTime%60
        }
        
    }
    func clear(){
        RestaurantsMappingHelper(context: moc).clearQueue(restaurant: restaurant)
    }
}
