//
//  SignUpPage.swift
//  my_table
//
//  Created by snlcom on 2023/08/13.
//

import SwiftUI

/// Signup view that users can create an account for customers or restaurant venues
struct SignUpView: View {
    
    @FetchRequest(sortDescriptors: []) var customers: FetchedResults<Customer>
    @FetchRequest(sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    
    // Set check for if login or signup page
    @Binding var isSignup: Bool
    
    // These are actually implemented modules that are required
    
    // Firebase authentication module
    @EnvironmentObject var authModel: AuthenticationModel
    
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    
    // managed object to access store
    @Environment(\.managedObjectContext) var moc
    @State private var passwordCheck: String = ""
    
    // Validation variables
    @State private var isFirstNameValid: Bool = true
    @State private var isLastNameValid: Bool = true
    @State private var isUsernameValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var isPhoneNumberValid: Bool = true
    @State private var isPasswordCheckValid: Bool = true
    @State private var isEmailValid: Bool = true
    
    // Firebase Singup Response
    @State private var signupResponse: String = ""
    
    //Choose mode
    
    @State private var isRestaurantSignUp: Bool = false
    @State private var isCustomerSignUp: Bool = false
    
    var body: some View {
        
        VStack{
            VStack{
                Text("My Table")
                    .font(.title.bold())
                Text("Sign up")
                    .font(.title3.bold())
                    .padding(.top, 20)
            }
            VStack{
                // MARK: User login
                
                ScrollView{
                    Toggle("Signing up as a venue?", isOn: $profileModel.isVenue)
                        .font(.callout.bold())
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    VStack{
                        
                        Text("First Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                            .padding(.bottom, -6)
                        TextField("First Name", text : $profileModel.firstName)
                            .padding()
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
                        
                        TextField("Last Name", text : $profileModel.lastName)
                            .padding()
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
                    VStack {
                        Group{
                            Text("Username")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .padding(.bottom, -6)
                                .padding(.top, 5)
                            TextField("Username", text : $profileModel.username)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("InputGrey"))
                                )
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                            if (!isUsernameValid) {
                                Text("Username is required")
                                    .foregroundColor(Color.red)
                            }
                            
                            Text("Email")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .padding(.bottom, -6)
                                .padding(.top, 5)
                            TextField("Email", text : $profileModel.email)
                                .textContentType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding()
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
                            
                            Text("Phone")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .padding(.bottom, -6)
                                .padding(.top, 5)
                            TextField("Phone Number", text : $profileModel.phone)
                                .textContentType(.telephoneNumber)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.phonePad)
                                .padding()
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
                    }
                    VStack {
                        
                        // MARK: Contact details
                        
                        
                        // MARK: Passwords/authentication
                        Group {
                            
                            Text("Password")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .padding(.bottom, -6)
                            SecureField("Password", text : $profileModel.password)
                                .textContentType(.password)
                                .textInputAutocapitalization(.never)
                                .padding()
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
                            
                            
                            Text("Confirm password")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .padding(.bottom, -6)
                            SecureField("Password Check", text : $passwordCheck)
                                .textContentType(.password)
                                .textInputAutocapitalization(.never)
                                .padding()
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
                        
                        // Error response from authentication api
                        VStack {
                            if (!signupResponse.isEmpty) {
                                Text(signupResponse)
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                        // MARK: interaction buttons
                        Group {
                            Button(action:{submitted()},label:{Text("Create Account")
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .frame(width: 375, height: 44)
                                    .background(
                                        Color("ColorYellow1")
                                    )
                                
                            }) .padding(EdgeInsets(top: 50, leading: 0, bottom: 5, trailing: 0))
                            
                            Button(action:{navigateToLogin()
                            },label:{Text("Log In")
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .frame(width: 375, height: 44)
                                    .background(Color("ColorGrey1"))
                            })
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }
            }
            
        }
    }
    
    /// switch between login and signup
    func navigateToLogin() {
        self.isSignup = !isSignup
    }
    
    /// Validate fields and process join
    func submitted() {
        // Clear the signup response before continueing
        signupResponse = ""
        
        // set all the values for the profile
        // TODO: refactor the below
        isFirstNameValid = isFirstNameValidCheck()
        isLastNameValid = isLastNameValidCheck()
        isUsernameValid = isUsernameValidCheck()
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
            
            // Use firebase authentication to signin and
            authModel.signUp(email: profileModel.email, password: profileModel.password) { result in
                switch result {
                case .success(let user):
                    print("signup success \(String(describing: user?.uid))")
                    profileModel.isLoggedIn = true
                    profileModel.userId = user!.uid
                    let storeLocalDataResult = ProfileDataMapperHelper(context: moc).signupUserProfileCreation(profileModel: profileModel, uid: user!.uid)
                case .failure(let error):
                    signupResponse = error.localizedDescription
                }
            }
        }
    }
    
    // TODO: create more robust valdidation for fields
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
    func isUsernameValidCheck() -> Bool {
        return profileModel.username.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isPasswordValidCheck() -> Bool {
        return profileModel.password.isEmpty ? false : true
    }
    /// validation check
    /// - Returns: True -> valid, false -> invalid
    func isPasswordCheckValidCheck() -> Bool {
        return passwordCheck.isEmpty || passwordCheck != profileModel.password ? false : true
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
    
    func customerMode(){
        
        isRestaurantSignUp = false
        isCustomerSignUp = true
        
    }
    func restaurantMode(){
        isRestaurantSignUp = true
        isCustomerSignUp = false
        
    }
    
    func createCustomerUser(){
        print("create customer")
    }
    func createRestaurantUser(){
        print("create restaurant")
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isSignup: .constant(true)).environmentObject(ProfileModel())
    }
}
