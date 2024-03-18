//
//  ProfileView.swift
//  MyTable
//
//  Created by Pascal Couturier on 21/8/2023.
//

import Foundation
import SwiftUI

/// Profile view where logged in users can access their  profile details
struct ProfileView: View {
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    
    @State private var isLoggedIn:Bool = false
    @State private var isCustomer:Bool = false
    @State private var isRestaurant:Bool = false
    @State private var isSignUp:Bool = false
    
    var body: some View {
        VStack{
            if(profileModel.isVenue){
                RestaurantProfileView()
                    .background(Color.black)
            }else{
                CustomerProfileView()
                    .background(Color.black)
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        // This is for preview so data is loaded
        // Toggle isCustomerLogin to change between loading venue and customer dummy data
        let isCustomerLogin = true
        
        let profileModel = ProfileModel()
        
        isCustomerLogin ? profileModel.loadDummyCustomerProfileData() : profileModel.loadDummyVenueProfileData()
        
        profileModel.isLoggedIn = true
        
        return ProfileView().environmentObject(profileModel)
    }
}

