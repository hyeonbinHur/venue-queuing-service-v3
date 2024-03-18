//
//  loginPage.swift
//  my_table
//
//  Created by snlcom on 2023/08/12.
//

import SwiftUI

/// The login view provided to users on initial load of application
struct LoginView: View {
    
    // MARK: Testing bool to either use the REST API login or the Firebase SDK login
    @State private var isRestApiLogin: Bool = true
    
    // Set check for if login or signup page
    @Binding var isSignup: Bool
    
    // The firebase authentication module
    @EnvironmentObject var authModel: AuthenticationModel
    // to access the data store
    @Environment(\.managedObjectContext) var moc
    
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    @State private var signInResponse: String = ""
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var hasValidationError = false
    
    // The below is used when logging in via the REST API Service
    @State private var response: FirebaseAuthLoginResponse?
    
    // TODO: remove the below as it's only for testing
    @State private var showingAlert = false
    
    var body: some View {
        
        ZStack{
            LogoCustomLayoutModule()
            VStack{
                
                Text("Welcome back!")
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                Text("We're glad to see you again")
                
                VStack {
                    Text("Login Details")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .padding(.leading, 30)
                    
                    TextField("Email" , text:$email)
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
                    
                    SecureField("Password" , text:$password)
                        .textContentType(.password)
                        .textInputAutocapitalization(.never)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("InputGrey"))
                        )
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.top, 20)
                    
                    Button(action:{showingAlert = true},label:{
                        HStack {
                            Text("Forgot password?")
                                .font(.callout)
                            Spacer()
                        }
                        .padding(.leading, 32)
                    })
                    // TODO: remove the below, heere for testing
                    .alert("Username: john@smith.com  password: 1234", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    
                    
                    
                    if (hasValidationError && signInResponse.isEmpty) {
                        Text("Email and Password are required")
                            .font(.callout)
                            .foregroundColor(Color.red)
                            .padding(.top, 10)
                            .padding(.leading, 34)
                            .padding(.trailing, 34)
                    }
                    
                    if (!signInResponse.isEmpty) {
                        Text(signInResponse)
                            .font(.callout)
                            .foregroundColor(Color.red)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    Button(action:{Submit()},label:{Text("Login")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .frame(width: 375, height: 44)
                            .background(
                                Color("ColorYellow1")
                            )
                        
                    })
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Button(action:{navigateToSignup()
                    },label:{Text("Sign up")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .frame(width: 375, height: 44)
                            .background(Color("ColorGrey1"))
                        
                    })
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    
                }
                .padding(.top, 100)
                Spacer()
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
        
    }
    
    /// switch between the login and signup views
    func navigateToSignup() {
        self.isSignup = true
    }
    
    /// Logs the user in and populates their data from core data after validating with firebase
    func Submit() {
        signInResponse = ""
        self.hasValidationError = false
        
        if (!password.isEmpty && !email.isEmpty) {
            
            if (isRestApiLogin) {
                // MARK: This is an example of using the REST API Endpoint to login the customer
                // We have implemented the Firebase SDK for login credentials which has custom methods for login and creation, however as part of the requirements
                // We have used a REST API that does the same
                // MARK: REST API User login
                FirebaseAuthRestApiService.shared.loginWithRestApi(email: email, password: password) { loginResponse in
                    if let response = loginResponse {
                        self.response = response
                        ProfileDataMapperHelper(context: moc).loginUserProfile(profileModel: profileModel, uid: response.localId)
                        self.profileModel.isLoggedIn = true
                    } else {
                        signInResponse = "Error signing in user"
                        self.profileModel.clearProfileData()
                        self.hasValidationError = true
                    }
                }
            } else {
                
                // MARK: Firebase SDK User login
                // if all fields are valid, try Firebase signup
                authModel.signIn(email: email, password: password) { result in
                    switch result {
                    case .success(let user):
                        print("signin success \(String(describing: user?.uid))")
                        ProfileDataMapperHelper(context: moc).loginUserProfile(profileModel: profileModel, uid: user!.uid)
                        self.profileModel.isLoggedIn = true
                    case .failure(let error):
                        signInResponse = error.localizedDescription
                        self.profileModel.clearProfileData()
                        self.hasValidationError = true
                    }
                }
            }
        } else {
            // falls into here if the password or email are not entered
            // TODO: make more tescriptive error responses
            self.hasValidationError = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignup: .constant(true)).environmentObject(ProfileModel())
    }
}
