//
//  RestaurantQueue.swift
//  MyTable
//
//  Created by snlcom on 2023/08/23.
//

import SwiftUI

/// The queue for restaurants to see how many people/groups are queueing
struct RestaurantQueue: View {
    
    // TODO: how to get the restaurant's data?, can we save it into local storage?
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    
    @State var customerList: [ProfileModel] = []
    
    @Environment(\.managedObjectContext) var moc
    @Binding var watingUsersArray: [String]
    @Binding var isEditing: Bool
    
   
    
    //    @State private var watingUserString:String = restaurantProfileModel.inQueue

    var body: some View {
        VStack{
            
            if let restaurant = RestaurantProfileDataMapperHelper(context:  moc).getStoredRestaurantByVenueId(venueId: restaurantProfileModel.venueId, in: moc){
                
                VStack(alignment: .leading){
                HStack{
                    Button{isEditing = false}
                label:{
                    Image(systemName: "chevron.backward")
                    Text("Back")
                    
                }
                .padding(.leading,20)
                    
                    Spacer()
                }
            }
            .padding(.bottom,10)
            
            Text(restaurantProfileModel.name)
                
                
                if let data = restaurantProfileModel.mainImage, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 300,height: 200)
                        .cornerRadius(15)
                        .padding(.bottom,20)
                }else{
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 300,height: 200)
                        .cornerRadius(15)
                        .padding(.bottom,20)
                }
                
            Text("Queue Status")
                .padding(.bottom,15)
            Text(restaurant.numOfQueue + " of teams are in the queue")
            ScrollView{
                
                ForEach($watingUsersArray, id: \.self) { userId in

                    QueueList(CustomerId: userId, watingUsersArray: $watingUsersArray)
                    
                }
            }
            .frame(
                maxHeight: 300)
           
            Spacer()
                
            }

        }
    }
    func kickFromQueue(){
        //Read data and compare the name, team number and remove the data
    }
    func ArrivedRestaurant(){
        //Read data and compare the queue name, team number and remove the data
    }
    
    func findUser(id: String)->Customer?{
        var foundCus =  ProfileDataMapperHelper(context: moc).findUserByID(userID: id, in: moc)
        return foundCus
    }
}

//struct RestaurantQueue_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantQueue()
//            
//    }
//}
