//
//  RestaurantProfileView.swift
//  MyTable
//
//  Created by snlcom on 2023/08/23.
//

import SwiftUI

/// Restaurant profile view where logged in restaurant owners can access their profile details
struct RestaurantProfileView: View {
    
    @EnvironmentObject var profileModel: ProfileModel
    // Restaurant Profile Object
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    @Environment(\.managedObjectContext) var moc
    
    @State var watingUsersArray: [String] = []
    @State private var isEditingRestaurant: Bool = false
    @State private var isEditingProfile: Bool = false
    @State private var isEditingCode: Bool = false
    @State private var isCheckQueue: Bool = false
    
    @EnvironmentObject var authModel: AuthenticationModel
    
    var body: some View {
        NavigationView{
            VStack{
                Text("My Table")
                    .font(.title.bold())
                
                Text("Profile")
                if let data = restaurantProfileModel.mainImage, let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                        )
                    
                }else{
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(5)
                }
                
                Text(restaurantProfileModel.name)
                    .font(.headline)
                    .padding(.bottom,50)
                VStack{
                    Button(action: {isEditingCode.toggle()} ,label: {Text("Change Validation Code")}
                    )
                    
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                    
                    Button(action: {changeStringToArray()} ,label: {Text("Check Queue")}
                    )
                    
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                    
                    Divider()
                        .padding(.leading,30)
                        .padding(.trailing,30)
                        .padding(.bottom,30)
                    
                    Button("Edit Profile"){
                        isEditingProfile.toggle()
                    }
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                    .padding(.top, 10)
                    .padding(.bottom,10)
                    
                    Button("Edit Restaurant Details"){
                        isEditingRestaurant.toggle()
                    }
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                    .padding(.top, 5)
                    .padding(.bottom,50)
                    
                    Button(action: {logout()}, label: {Text("Logout")})
                    
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(width: 375, height: 44)
                        .background(
                            Color("ColorGrey1")
                        )
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isEditingRestaurant){
                EditRestaurantProfile(isEditing: $isEditingRestaurant)
            }
            .fullScreenCover(isPresented: $isEditingProfile){
                EditProfile(isEditing: $isEditingProfile)
            }
            .fullScreenCover(isPresented: $isEditingCode){
                validationView(numberOfFields: 5, isEditing: $isEditingCode)
            }
            .fullScreenCover(isPresented: $isCheckQueue){
                RestaurantQueue(watingUsersArray: $watingUsersArray,isEditing: $isCheckQueue)
            }
        }
    }
    
    /// Logs the user out of authentication and back to home screen
    func logout() {
        authModel.signOut(profileModel: profileModel)
    }
    
    func changeStringToArray(){
        if let restaurant = RestaurantProfileDataMapperHelper(context:  moc).getStoredRestaurantByVenueId(venueId: restaurantProfileModel.venueId, in: moc){
            watingUsersArray = restaurant.inQueue.components(separatedBy: ",").filter { !$0.isEmpty }
        }
        
        
        isCheckQueue.toggle()
    }
    
}

struct RestaurantProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // Set dummy test data
        let restaurantDummyData = RestaurantProfileModel()
        restaurantDummyData.name = "Test Restaurant"
        
        return RestaurantProfileView()
            .environmentObject(restaurantDummyData)
    }
}
