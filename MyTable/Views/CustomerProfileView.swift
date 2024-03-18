//
//  CustomerProfileView.swift
//  MyTable
//
//  Created by snlcom on 26/8/2023.
//

import SwiftUI

/// Profile view where logged in users can access their  profile details
struct CustomerProfileView: View {
    @EnvironmentObject var profileModel: ProfileModel
    @State private var isEditing: Bool = false
    @EnvironmentObject var authModel: AuthenticationModel
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationView{
            VStack {
                
                Button("check"){
                    findUser(id: profileModel.userId)
                }
                Text("Welcome \(profileModel.firstName)")
                    .font(.title.bold())
                
                if let data = profileModel.avatar, let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(100)
                }else{
                    Image(systemName: "person")
                        .resizable()
                        .padding(30)
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color("ColorYellow1"))
                        )
                }
                    
                
                Text("\(profileModel.username)")
                    .font(.headline)
                
                
                Button("Edit Profile"){
                    isEditing = true
                }
                
                .font(.headline)
                .foregroundColor(Color.black)
                .frame(width: 375, height: 44)
                .background(
                    Color("ColorYellow1")
                )
                .padding(.top, 20)
                .padding(.bottom,30)
                Divider()
                    .padding(.leading,30)
                    .padding(.trailing,30)
                    .padding(.bottom,30)
                
                Button(action: {logout()}, label: {Text("Logout")})
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorGrey1")
                    )
                }
                Spacer()
            }
        .fullScreenCover(isPresented: $isEditing){
            
        } content: {
            EditProfile(isEditing: $isEditing)
        }
        }
    /// Logs the user out of authentication and back to home screen
    func logout() {
        authModel.signOut(profileModel: profileModel)
    
    }
    
    func findUser(id: String){
       var foundCus =  ProfileDataMapperHelper(context: moc).findUserByID(userID: id, in: moc)
        print(id)
        print(foundCus?.firstname)
    }
}

struct CustomerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        // This is for preview so data is loaded
        var profileModel = ProfileModel()
        
        profileModel.loadDummyCustomerProfileData()
        profileModel.isLoggedIn = true
        
        return CustomerProfileView().environmentObject(profileModel)
    }
}
