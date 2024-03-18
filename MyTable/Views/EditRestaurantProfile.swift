//
//  EditRestaurantProfile.swift
//  MyTable
//
//  Created by snlcom on 2023/08/23.
//

import SwiftUI

/// Edit restaurant profile, this is for users that are logged in and manage their restaurant can edit those restaurant details. Sometimes there are details that are not visible to customers and here is where the restaurant owner/manager can control this
struct EditRestaurantProfile: View {
    // Binding for profile
    
    @EnvironmentObject var profileModel: ProfileModel
    // Restaurant Profile Object
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    // to access the data store
    @Environment(\.managedObjectContext) var moc
    
    // Validation variables
    @State private var isName: Bool = true
    @State private var isPhone: Bool = true
    @State private var isWebsiteUrl: Bool = true
    @State private var isMenuUrl: Bool = true
    @State private var isAddress: Bool = true

    @State var showAddressAutocompleteList: Bool = false
    
    @State private var isValid : Bool = false
    @Binding var isEditing: Bool
    
    
    //editing image
    
    @ObservedObject var coreDataVM1 = ImageViewModel()
    @ObservedObject var coreDataVM2 = ImageViewModel()
    @ObservedObject var coreDataVM3 = ImageViewModel()
    @ObservedObject var coreDataVM4 = ImageViewModel()
    @ObservedObject var coreDataVM5 = ImageViewModel()
    @State var isImagePicker1: Bool = false
    @State var isImagePicker2: Bool = false
    @State var isImagePicker3: Bool = false
    @State var isImagePicker4: Bool = false
    @State var isImagePicker5: Bool = false
    @State var isImageSelected: Bool = false
    @State private var newImage1: UIImage = UIImage()
    @State private var newImage2: UIImage = UIImage()
    @State private var newImage3: UIImage = UIImage()
    @State private var newImage4: UIImage = UIImage()
    @State private var newImage5: UIImage = UIImage()
    var body: some View {
        VStack {
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
            
            ScrollView{
                
                ScrollView(.horizontal){
                    
                    HStack(spacing : 10){
                        ZStack(alignment: .trailing){
                            if let NewData = coreDataVM1.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 180,height: 180)
                                    .cornerRadius(30)
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .padding(.trailing,20)
                                    .padding(.top,120)
                                    .onTapGesture {
                                        self.isImagePicker1 = true
                                        isImageSelected = true
                                    }
                                
                            }else{
                                if let data = restaurantProfileModel.mainImage, let uiImage = UIImage(data: data){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 180,height: 180)
                                        .cornerRadius(30)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .padding(.trailing,20)
                                        .padding(.top,120)
                                        .onTapGesture {
                                            self.isImagePicker1 = true
                                            isImageSelected = true
                                        }
                                }else{
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 180,height: 180)
                                        .cornerRadius(30)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .padding(.trailing,20)
                                        .padding(.top,120)
                                        .onTapGesture {
                                            self.isImagePicker1 = true
                                            isImageSelected = true
                                        }
                                    
                                }
                            }
                            
                            
                        }
                        .sheet(isPresented: $isImagePicker1, content: {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM1.selectedImage)
                        })
                        .padding(.leading,15)
                        VStack{
                            ZStack(alignment: .trailing){
                                if let NewData = coreDataVM2.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .cornerRadius(15)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .padding(.trailing,8)
                                        .padding(.top,50)
                                        .onTapGesture {
                                            self.isImagePicker2 = true
                                            isImageSelected = true
                                        }
                                }else{
                                    if let data = restaurantProfileModel.subImage1, let uiImage = UIImage(data: data){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker2 = true
                                                isImageSelected = true
                                            }
                                        
                                    }else{
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker2 = true
                                                isImageSelected = true
                                            }
                                    }
                                    
                                }
                               
                            }
                            .sheet(isPresented: $isImagePicker2, content: {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM2.selectedImage)
                            })
                            
                            ZStack(alignment: .trailing){
                                if let NewData = coreDataVM3.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .cornerRadius(15)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .padding(.trailing,8)
                                        .padding(.top,50)
                                        .onTapGesture {
                                            self.isImagePicker3 = true
                                            isImageSelected = true
                                        }

                                    
                                }else{
                                    if let data = restaurantProfileModel.subImage2, let uiImage = UIImage(data: data){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker3 = true
                                                isImageSelected = true
                                            }

                                        
                                    }else{
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker3 = true
                                                isImageSelected = true
                                            }
                                    }
                                    
                                }
                                
                            }
                            .sheet(isPresented: $isImagePicker3, content: {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM3.selectedImage)
                            })
                            
                        }
                        
                        VStack{
                            ZStack(alignment: .trailing){
                                if let NewData = coreDataVM4.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .cornerRadius(15)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .padding(.trailing,8)
                                        .padding(.top,50)
                                        .onTapGesture {
                                            self.isImagePicker4 = true
                                            isImageSelected = true
                                        }
                                    
                                }else{
                                    if let data = restaurantProfileModel.subImage3, let uiImage = UIImage(data: data){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker4 = true
                                                isImageSelected = true
                                            }
                                        
                                    }else{
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker4 = true
                                                isImageSelected = true
                                            }
                                        
                                    }
                                    
                                }
                                
                            }
                            .sheet(isPresented: $isImagePicker4, content: {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM4.selectedImage)
                            })
                            
                            ZStack(alignment: .trailing){
                                if let NewData = coreDataVM5.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .cornerRadius(15)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .padding(.trailing,8)
                                        .padding(.top,50)
                                        .onTapGesture {
                                            self.isImagePicker5 = true
                                            isImageSelected = true
                                        }
                                    
                                }else{
                                    if let data = restaurantProfileModel.subImage2, let uiImage = UIImage(data: data){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker5 = true
                                                isImageSelected = true
                                            }
                                        
                                    }else{
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 80,height: 80)
                                            .cornerRadius(15)
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 15,height: 15)
                                            .padding(.trailing,8)
                                            .padding(.top,50)
                                            .onTapGesture {
                                                self.isImagePicker5 = true
                                                isImageSelected = true
                                            }
                                        
                                    }
                                    
                                }
                                
                            }
                            .sheet(isPresented: $isImagePicker5, content: {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM5.selectedImage)
                            })
                            
                        }
                    }
                }
                .padding(.bottom,15)
                VStack{
                    VStack{
                        Text("Business registration number")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.businessRegoNumber)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        
                    }
                    
                    VStack{
                        Text("Restaurant name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.name)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isName) {
                            Text("The name is required")
                                .foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Text("Restaurant phone number")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.phone)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isPhone) {
                            Text("Phone number is required")
                                .foregroundColor(Color.red)
                        }
                    }
                    
                    VStack{
                        Text("Restaurant Slug")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.slug)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        
                    }
                    VStack{
                        Text("Restaurant website url")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.websiteUrl)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isWebsiteUrl) {
                            Text("Website url is required")
                                .foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Text("Restaurant menu url")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField("", text : $restaurantProfileModel.menuUrl)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isMenuUrl) {
                            Text("Menu url is required")
                                .foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Text("Restaurant address")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        AddressAutocompleteModule(fullAddress: $restaurantProfileModel.fullAddressString, longitude: $restaurantProfileModel.longitude, latitude: $restaurantProfileModel.latitude, showList: $showAddressAutocompleteList)
//                        if (!restaurantProfileModel.fullAddressString.isEmpty) {
//                            Text("The address is required")
//                                .foregroundColor(Color.red)
//                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {submitted()} ,label: {Text("Update Details")}
                    )
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                }
                Spacer()
            }
        }
       
    }
    
    /// Validates the fields on profile edit and updates in the data store as well
    func submitted() {
        isName = nameValid()
        isPhone = phoneNumberValid()
        isWebsiteUrl = webUrlValid()
        isMenuUrl = menuUrlValid()
        isAddress = addressValid()
        if (
            isName &&
            isPhone &&
            isWebsiteUrl &&
            isMenuUrl &&
            isAddress
        ) {
            if let NewData = coreDataVM1.selectedImage.jpegData(compressionQuality: 0.1){
                restaurantProfileModel.mainImage = coreDataVM1.selectedImage.jpegData(compressionQuality: 0.1)
            }
            if let NewData = coreDataVM2.selectedImage.jpegData(compressionQuality: 0.1){
                restaurantProfileModel.subImage1 = coreDataVM2.selectedImage.jpegData(compressionQuality: 0.1)
                
            }
            if let NewData = coreDataVM3.selectedImage.jpegData(compressionQuality: 0.1){
                restaurantProfileModel.subImage2 = coreDataVM3.selectedImage.jpegData(compressionQuality: 0.1)
                
            }
            if let NewData = coreDataVM4.selectedImage.jpegData(compressionQuality: 0.1){
                restaurantProfileModel.subImage3 = coreDataVM4.selectedImage.jpegData(compressionQuality: 0.1)
                
            }
            if let NewData = coreDataVM5.selectedImage.jpegData(compressionQuality: 0.1){
                restaurantProfileModel.subImage4 = coreDataVM5.selectedImage.jpegData(compressionQuality: 0.1)
                
            }
            // Update the restaurant details
            RestaurantProfileDataMapperHelper(context: moc).updateRestaurantByVenueId(restaurantProfileModel: restaurantProfileModel)
            isValid = true;
            isEditing = true;
        }
    }
    
    // TODO: add better validation checks here
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func nameValid() -> Bool{
        return restaurantProfileModel.name.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func phoneNumberValid() -> Bool{
        return restaurantProfileModel.phone.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func webUrlValid() -> Bool{
        return restaurantProfileModel.websiteUrl.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func menuUrlValid() -> Bool{
        return restaurantProfileModel.menuUrl.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func addressValid() -> Bool {
        return restaurantProfileModel.fullAddressString.isEmpty ? false : true
    }
}

struct EditRestaurantProfile_Previews: PreviewProvider {
    static var previews: some View {
        
        // This is for preview so data is loaded
        let profileModel = ProfileModel()
        profileModel.loadDummyVenueProfileData()
        profileModel.isLoggedIn = true
        
        return EditRestaurantProfile(isEditing: .constant(true)).environmentObject(profileModel)
            .environmentObject(RestaurantProfileModel())
    }
}
