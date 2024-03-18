# Firebase Auth Rest API Service

The application uses the **Firebase Authentication SDK** as well as the REST API for the login integration

## Overview

The firebase authentication SDK has been installed as one of the key dependencies of the application to help with secure signin and authentication. The rest api uses the firebase api key to hit the specific endpoint for validation with a POST request and validates the user credentials being passed.

This would be the `email` and `password` for the user attempting to login

### Api Key

The api key is not stored directly in the code, it is within a `plist` and the service retieves the key from the list and uses it to validate the endpoint

```swift
guard let path = Bundle.main.path(forResource: "Api-Keys", ofType: "plist") else { return }
guard let dictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> else {return}
let firebaseApiKey = dictionary["firebaseApiKey"] as? String

let endpoint = "\(authApiEndpoint)\(firebaseApiKey)
```

### API Response

The api response can return with a successful login and the `userId` or `uid`, however there is also the response error that can be returned in case there is a failed login

### Usage Example

When using this login function it has a completion handler. The use case example is below:

```swift
// Takes in the username and password then with the response wou can adjust what needs to be done
// in this example we're updating the profile details on success and if there is a failure, it triggers the error message
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
```