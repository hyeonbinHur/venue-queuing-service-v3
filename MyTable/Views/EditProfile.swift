//
//  EditProfile.swift
//  MyTable
//
//  Created by snlcom on 2023/08/23.
//

import SwiftUI

/// edit profile details, this is where logged in users can edit their own profile details
struct EditProfile: View {
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var Email: String = ""
    @State private var phoneNumber: String = ""
    @State private var userName: String = ""
    // to access the data store
    @Environment(\.managedObjectContext) var moc
    
    // Validation variables
    @State private var isFirstNameValid: Bool = true
    @State private var isLastNameValid: Bool = true
    @State private var isUsernameValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var isPhoneNumberValid: Bool = true
    @State private var isPasswordCheckValid: Bool = true
    @State private var isEmailValid: Bool = true
    @State private var isShowing: Bool = false
    
   
    @Binding var isEditing: Bool
    
    //editing image
    @ObservedObject var coreDataVM = ImageViewModel()
    @State var isImagePicker: Bool = false
    @State var isImageSelected: Bool = false
    @State private var newImage: UIImage = UIImage()
    
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
                if let NewData = coreDataVM.selectedImage.jpegData(compressionQuality: 0.1), let uiImage = UIImage(data: NewData) {
                    ZStack{
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(100)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 30, height: 30)
                            .padding(.top,120)
                            .padding(.leading,110)
                            .onTapGesture {
                                self.isImagePicker = true
                                isImageSelected = true
                            }
                    }
                    
                }else{
                    if let data = profileModel.avatar, let uiImage = UIImage(data: data){
                        ZStack{
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(100)
                            Image(systemName: "plus.circle")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .padding(.top,120)
                                .padding(.leading,110)
                                .onTapGesture {
                                    self.isImagePicker = true
                                    isImageSelected = true
                                }
                        }
                    }else
                    {
                        ZStack{
                            Image(systemName: "person")
                                .resizable()
                                .padding(30)
                                .frame(width: 150, height: 150)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(Color("ColorYellow1"))
                                )
                            Image(systemName: "plus.circle")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .padding(.top,120)
                                .padding(.leading,110)
                                .onTapGesture {
                                    self.isImagePicker = true
                                    isImageSelected = true
                                }
                        }
                        
                    }
                    
                }
                
                VStack{
                    Text("First Name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .padding(.bottom, -6)
                        .padding(.top, 5)
                    TextField(profileModel.firstName, text : $firstName)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("InputGrey"))
                        )
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    
                    
                    if (!isFirstNameValid) {
                        Text("First name is required")
                            .foregroundColor(Color.red)
                    }
                    
                }
                VStack{
                    Text("Last Name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .padding(.bottom, -6)
                        .padding(.top, 5)
                    TextField(profileModel.lastName, text : $lastName)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("InputGrey"))
                        )
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    if (!isLastNameValid) {
                        Text("Last name is required")
                            .foregroundColor(Color.red)
                    }
                }
                
                VStack{
                    VStack{
                        Text("Email")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField(profileModel.email, text : $Email)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isEmailValid) {
                            Text("Includes @ in your email")
                                .foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Text("Phone number")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        TextField(profileModel.phone, text : $phoneNumber)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isPhoneNumberValid) {
                            Text("Phone number must be 10 numbers")
                                .foregroundColor(Color.red)
                        }
                    }
                    Text("Username")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .padding(.bottom, -6)
                        .padding(.top, 5)
                    TextField(profileModel.username, text : $userName)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("InputGrey"))
                        )
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    if (!isUsernameValid) {
                        Text("Username must not be less than 6 letters")
                            .foregroundColor(Color.red)
                    }
                    VStack{
                        Text("Password")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        
                        SecureField("", text : $password)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isPasswordValid) {
                            Text("Passwords is required")
                                .foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Text("Password Check")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                            .padding(.top, 5)
                        
                        SecureField("", text : $passwordCheck)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("InputGrey"))
                            )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        if (!isPasswordCheckValid) {
                            Text("Passwords are not matched")
                                .foregroundColor(Color.red)
                        }
                    }
                    Button(action: {submitted()} ,label: {Text("Edit Profile")}
                    )
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 375, height: 44)
                    .background(
                        Color("ColorYellow1")
                    )
                    .padding(.top, 20)
                }
            }
        }
        .sheet(isPresented: $isImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM.selectedImage)
        })
    }
    
    // *Todo Validation check -> edit Profile*
    /// Validates the fields on profile edit and updates in the data store as well
    func submitted() {
        // set all the values for the profile
        // TODO: refactor the below
        isFirstNameValid = isFirstNameValidCheck()
        isLastNameValid = isLastNameValidCheck()
        isUsernameValid = isUserIdValidCheck()
        isPasswordValid = isPasswordValidCheck()
        isPasswordCheckValid = isPasswordCheckValidCheck()
        isPhoneNumberValid = isPhoneNumberValidCheck()
        isEmailValid = isEmailValidCheck()
        if (
            isFirstNameValid &&
            isLastNameValid &&
            isUsernameValid &&
            isPasswordValid &&
            isPasswordCheckValid &&
            isPhoneNumberValid &&
            isEmailValid
        ) {
            // Helper method to update the stored data
            if let NewData = coreDataVM.selectedImage.jpegData(compressionQuality: 0.1){
                profileModel.selectedImage = coreDataVM.selectedImage
                profileModel.firstName = firstName
                profileModel.lastName = lastName
                profileModel.username = userName
                profileModel.password = password
                profileModel.phone = phoneNumber
                profileModel.email = Email
                
                profileModel.avatar = coreDataVM.selectedImage.jpegData(compressionQuality: 0.1)
                
                
            }
            
            ProfileDataMapperHelper(context: moc).updateCustomerByUserId(profileModel: profileModel)
            print("Edit Valid")
            isEditing = false
        }
    }
    
    
    // TODO: improve the validation requirements apart from just being required
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isFirstNameValidCheck() -> Bool {
        return profileModel.firstName.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isLastNameValidCheck() -> Bool {
        return profileModel.lastName.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isUserIdValidCheck() -> Bool {
        return profileModel.username.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isPasswordValidCheck() -> Bool {
        return password.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isPasswordCheckValidCheck() -> Bool {
        return passwordCheck.isEmpty || passwordCheck != password ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isPhoneNumberValidCheck() -> Bool {
        return profileModel.phone.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isEmailValidCheck() -> Bool {
        return profileModel.email.isEmpty ? false : true
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        
        // This is for preview so data is loaded
        var profileModel = ProfileModel()
        profileModel.loadDummyCustomerProfileData()
        profileModel.isLoggedIn = true
        
        return EditProfile(isEditing:.constant(true)).environmentObject(profileModel)
    }
}
