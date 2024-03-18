//
//  FirebaseAuthRestApiService.swift
//  MyTable
//
//  Created by Pascal Couturier on 11/10/2023.
//

import Foundation

// We have implemented the Firebase Authentication SDK for general login and authentication services, however, part of the rubric is to use a REST api endpoint from the assignment 1 api usage, so we will implement the REST API access for rubric purposes

// Resources attained from: https://firebase.google.com/docs/reference/rest/auth


/// This is the firebase authentication service using the REST API
struct FirebaseAuthRestApiService {
    // Create Singleton value
    static let shared = FirebaseAuthRestApiService()
    
    // TODO: firebase api key should not be hard coded here, need to remove and add from secure location
//    let firebaseApiKey = "AIzaSyAZ0bAGS7-7wKPMqaMD4lCXYHYKb-Uww5w"
    // endpoint url
    let authApiEndpoint = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
    
    // Method to login and returns the logged in user ID
    /// Firebase login method using the REST API
    /// - Parameters:
    ///   - email: Email address for the user
    ///   - password: password for the user
    ///   - completion: The returned result after the process is completed
    func loginWithRestApi(email: String, password: String, completion: @escaping (FirebaseAuthLoginResponse?) -> Void) {
        
        // Get the firebase api key from the plist
        guard let path = Bundle.main.path(forResource: "Api-Keys", ofType: "plist") else { return }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> else {return}
        let firebaseApiKey = dictionary["firebaseApiKey"] as? String
        
        // Set endpoint
        // TODO: when coming from the plist it wraps the value of the string so need to remove them, need to do this better than replacement
        let endpoint = "\(authApiEndpoint)\(firebaseApiKey)".replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "")
        
        // Create the body
        let requestBody = ["email": email, "password": password, "returnSecureToken": true] as [String : Any]
        
        guard let body = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return
        }
        
        // Only run the api reqeust if the json is serialized and there is body returned
        if (!body.isEmpty) {
            // Create the request
            var request = URLRequest(url: URL(string: endpoint)!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
            
            // Send the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for error
                if let error = error {
                    // Handle the error
                    print("error signing up: ", error)
                    completion(nil)
                    return
                }
                
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(FirebaseAuthLoginResponse.self, from: data) {
                        completion(decodedResponse)
                    } else {
                        // try decoding the erro message
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            print("error: ", errorResponse)
                            // TODO: add proper error loggin and response here
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                }
            }.resume()
        }
    }
}

/// Response proviced from Firebase login success
struct FirebaseAuthLoginResponse: Codable {
    let localId: String
    let email: String
    let idToken: String
    let registered: Bool
    let refreshToken: String
    let expiresIn: String
}

/// Error response from Firebase login attempt
struct ErrorResponse: Codable {
    let error: ErrorDetail
}

/// Error details from firebase login
struct ErrorDetail: Codable {
    let code: Int
    let message: String
    let errors: [ErrorInfo]
}

/// Detailed information of error from firebase auth login
struct ErrorInfo: Codable {
    let message: String
    let domain: String
    let reason: String
}
