//
//  SignupRestaurantDetailsModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 2/10/2023.
//

import SwiftUI

/// Signup Restaurant details, after a user has logged in or created an account, if it's a restaurant then they need to populate these details before progressing into the app so their restaurant can be registered. If they logout before completing this, when they login again they will be presented with this screen until it is completed
struct SignupRestaurantDetailsModule: View {
    
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    // Restaurant Profile Object
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    
    // managed object to access store
    @Environment(\.managedObjectContext) var moc
    
    //Restaurant have longitude and latitude here as they are strings in text field
    // but will be mapped to numbers in the restaurant profile model on submit
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    @State private var showAddressAutocompleteList: Bool = false
    
    //Restaurant validation
    @State private var isName: Bool = true
    @State private var isPhone: Bool = true
    @State private var isWebsiteUrl: Bool = true
    @State private var isLatitude: Bool = true
    @State private var isLongitude: Bool = true
    @State private var isMenuUrl: Bool = true
    

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
    
    @State var businessNumber: String = ""
    @State var restaurantName: String = ""
    @State var restaurantPhone: String = ""
    @State var restaurantSlug: String = ""
    @State var restaurantWebsite: String = ""
    @State var restaurantMenu: String = ""
    @State var restaurantAdd: String = ""

    
    var body: some View {
        VStack {
            Text("Nearly there!")
                .font(.largeTitle.bold())
            
            ScrollView{
                Text("A few last details to complete your restaurant profile")
                    .font(.title2.bold())
                    .padding(.top, 10)
                    .padding(.bottom, 40)
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
                        TextField("", text : $businessNumber)
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
                        TextField("", text : $restaurantName)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isName) {
                            Text("Includes @ in your email")
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
                        TextField("", text : $restaurantPhone)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isPhone) {
                            Text("Includes @ in your email")
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
                        TextField("", text : $restaurantSlug)
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
                        TextField("", text : $restaurantWebsite)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isWebsiteUrl) {
                            Text("Username must not be less than 6 letters")
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
                        TextField("", text : $restaurantMenu)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isMenuUrl) {
                            Text("Username must not be less than 6 letters")
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
                        AddressAutocompleteModule(fullAddress: $restaurantProfileModel.fullAddressString, longitude: $restaurantProfileModel.longitude, latitude: $restaurantProfileModel.latitude,
                                                  showList: $showAddressAutocompleteList)
                        //                        if (!restaurantProfileModel.fullAddressString.isEmpty) {
                        //                            Text("The address is required")
                        //                                .foregroundColor(Color.red)
                        //                        }
                    }
                    Button(action:{submitDetails()},label:{Text("Submit Restaurant Details")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .frame(width: 375, height: 44)
                            .background(
                                Color("ColorYellow1")
                            )
                        
                    }) .padding(EdgeInsets(top: 50, leading: 0, bottom: 15, trailing: 0))
                }
                Spacer()
            }
        }
    }
}

struct SignupRestaurantDetailsModule_Previews: PreviewProvider {
    static var previews: some View {
        SignupRestaurantDetailsModule()
            .environmentObject(ProfileModel())
            .environmentObject(RestaurantProfileModel())
    }
}

extension SignupRestaurantDetailsModule {
    
    // submit button clicked and update restaurant details
    /// After restaurant signup they need to submit the restaurant details to progress within the application. This updates the details for the restaurant
    func submitDetails() {
        // TODO: correct validation here for double casting from string
        restaurantProfileModel.latitude = Double(latitude) ?? 0.0
        restaurantProfileModel.longitude = Double(longitude) ?? 0.0
        
        if let NewData = coreDataVM1.selectedImage.jpegData(compressionQuality: 0.1){
            restaurantProfileModel.mainImage = NewData
        }
        if let NewData = coreDataVM2.selectedImage.jpegData(compressionQuality: 0.1){
            restaurantProfileModel.subImage1 = NewData
            
        }
        if let NewData = coreDataVM3.selectedImage.jpegData(compressionQuality: 0.1){
            restaurantProfileModel.subImage2 = NewData
            
        }
        if let NewData = coreDataVM4.selectedImage.jpegData(compressionQuality: 0.1){
            restaurantProfileModel.subImage3 = NewData
            
        }
        if let NewData = coreDataVM5.selectedImage.jpegData(compressionQuality: 0.1){
            restaurantProfileModel.subImage4 = NewData
            
        }
        
        // This then maps the restaurant model to the stored data in core data and creates a new
        // as this checks and updates the model if it exists and creates a new one if it doesn't
        
        
        restaurantProfileModel.businessRegoNumber = businessNumber
        restaurantProfileModel.name = restaurantName
        restaurantProfileModel.phone = restaurantPhone
        restaurantProfileModel.slug = restaurantSlug
        restaurantProfileModel.websiteUrl = restaurantWebsite
        restaurantProfileModel.menuUrl = restaurantMenu
 
            restaurantProfileModel.mainImage = coreDataVM1.selectedImage.jpegData(compressionQuality: 0.1)
      
            restaurantProfileModel.subImage1 = coreDataVM2.selectedImage.jpegData(compressionQuality: 0.1)
            
        
            restaurantProfileModel.subImage2 = coreDataVM3.selectedImage.jpegData(compressionQuality: 0.1)
        
            restaurantProfileModel.subImage3 = coreDataVM4.selectedImage.jpegData(compressionQuality: 0.1)
      
       
            restaurantProfileModel.subImage4 = coreDataVM5.selectedImage.jpegData(compressionQuality: 0.1)
    
        
        RestaurantProfileDataMapperHelper(context: moc).loadOrCreateRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, userId: profileModel.userId)
    }
    
    // TODO: add valid form validation here
}
