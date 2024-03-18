//
//  ProfileViewModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 21/8/2023.
//

import Foundation
import FirebaseAuth

// This will contain the login model for authentication specifically when connecting to an
// external resource for authentication
/// Firebase authentication model that handles the logging in and out of users
class AuthenticationModel: ObservableObject {
    
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    /// Sets a watcher to see state changes in Auth
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
    }
    
    /// Firebase signup method to create a user
    /// - Parameters:
    ///   - email: email of user
    ///   - password: password of user
    ///   - completion: returns `user` on success or error on fail
    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User?, Error>) -> Void
    ) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (result, error) in
            if let error = error {
                // if there is an error log the error
                // TODO: add error monitoring
                print(error.localizedDescription)
                
                completion(.failure(error))
            } else {
                // Update and add new user details to the store
                self.user = result?.user
                
                // TODO: map and retrieve user data after signup
                
                print("signup success")
                completion(.success(result?.user))
            }
        }
    }
    
    /// Firebase signin method
    /// - Parameters:
    ///   - email: email of user
    ///   - password: password of user
    ///   - completion: `user` object on usccess, error response on fail
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User?, Error>) -> Void
    ) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if let error = error {
                // if there is an error log the error
                // TODO: add error monitoring
                print(error.localizedDescription)
                
                completion(.failure(error))
            } else {
                self.user = result?.user
                
                // TODO: map and retrieve user data after signin
                
                print("signin success")
                completion(.success(result?.user))
            }
        }
    }
    
    /// signout the logged in user and clear all profile data
    /// - Parameter profileModel: logged in profile details of user
    func signOut(profileModel: ProfileModel) {
        // TODO: Clean up how this works
        
        // Signout from authentication
        try? Auth.auth().signOut()
        // clear the user
        self.user = nil
        
        profileModel.clearProfileData()
    }
    
    func deleteUserAccount(profileModel: ProfileModel) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error deleting user account: \(error.localizedDescription)")
                // Handle the error here, such as displaying an alert
            } else {
                print("User account deleted successfully.")
                // Perform any necessary clean-up or log the user out
                self.user = nil
                profileModel.clearProfileData()
            }
        }
    }
}
