//
//  QueueList.swift
//  MyTable
//
//  Created by snlcom on 2023/08/23.
//

import SwiftUI

// The queue list item

/// The queue list item to display users in a queue for a venue
struct QueueList: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var CustomerId: String
    
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    @Binding var watingUsersArray: [String]
    
    var body: some View {
        VStack(){
            
            if let customerInQueue = findUser(id: CustomerId){
                Text("Customer name "+customerInQueue.firstname)
                    .padding(.top,10)
                    .padding(.bottom, 5)
                Text("Team number"+customerInQueue.teamNumber)
            }
            Divider()
            
            HStack{
                Button("Arrived"){
                    leaveTheQueue()
                }
                .foregroundColor(.black)
                .frame(width: 120,height: 30)
                .background(Color("ColorGrey1"))
                .border(Color("ColorGrey1"),width: 1)
                
                Button("Kick"){
                    leaveTheQueue()
                }
                .foregroundColor(.black)
                .frame(width: 120,height: 30)
                .background(Color("ColorGrey1"))
                .border(Color("ColorGrey1"),width: 1)
                
                
            }
            .padding(10)
        }
        .frame(
            maxWidth: 300,
            minHeight: 100,
            maxHeight: 150,
            alignment: .top
        )
        .background(Color("ColorYellow1"))
        .cornerRadius(20)
    }
    
    func findUser(id: String)->Customer?{
        var foundCus =  ProfileDataMapperHelper(context: moc).findUserByID(userID: id, in: moc)
        return foundCus
    }
    
    /// the restaurant accept of kick a team in a queue through this function, since there isn't any different functioanlity between kick and accept, both use one function
    func leaveTheQueue(){
        let oldQueue = restaurantProfileModel.inQueue.components(separatedBy: ",")
        let newQueue = oldQueue.filter { $0 != CustomerId }
        let refreshedQueue:String = newQueue.joined(separator: ",")
        ProfileDataMapperHelper(context: moc).acceptFromRestaurant(userId: CustomerId)
        if let oldNumofQueue:Int = Int(restaurantProfileModel.numOfQueue){
            let QueueMinusOne = oldNumofQueue-1
            let newNumOfQueue:String = String(QueueMinusOne)
            RestaurantProfileDataMapperHelper(context: moc).refreshTheQueue(restaurantProfileModel: restaurantProfileModel, refreshedQueue: refreshedQueue, newNumOfQueue: newNumOfQueue)
            print(newNumOfQueue)
        }
        watingUsersArray = watingUsersArray.filter { $0 != CustomerId }

        print(refreshedQueue)
        
        
        
    }
    
}


