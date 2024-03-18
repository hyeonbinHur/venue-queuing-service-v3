# Profile Data Mapper Helper

This helper assists with mapping the profile data between the storage (Core Data) and the application.

## Overview

Having this helper or service allows formapping data to the models that the application can understand. 

This is particularly important for situations where we may change the data source, i.e. changing from Core Data store to an SQL database for example. we don't need to adjust all the implementations throughout the project, we just update the mapping fields in the mapping helper.

### Usage Examples

This data mapping helper has a few methods within it that can be used through the application and their usage is listed below:

#### getStoredCustomerByUserId

This gets the customer data that is stored within Core Data by the `userId` provided.

If the userId can't be found then it returns a `nil` value

**Usage:** 
```swift
// This needs to be placed at the top view to be able to pass the context into the function
@Environment(\.managedObjectContext) var moc
...

// Requires the contect to be passed through so requires  NSManagedObjectContext
let returnedCustomer = ProfileDataMapperHelper(context: moc).getStoredCustomerByUserId(userId: "{userId}", in moc)
```

#### updateCustomerByUserId

This allows the customer data in the store to be updatd based on their `userId` provided to it from the `ProfileModel` that is used in the constructor.

There is no return value for this.

**Usage:**
```swift
// This needs to be placed at the top view to be able to pass the context into the function
@Environment(\.managedObjectContext) var moc

// Requires the contect to be passed through so requires  NSManagedObjectContext
ProfileDataMapperHelper(context: moc).updateCustomerByUserId(profileModel: profileModel)
```

#### loginUserProfile

This logs the user profile in, it is used once the user logs in with firebase successfully, it then retrieves the matching user data and populates the model with the returned core data.

The `EnvironmentObject` is passed through so it updates that object directly and then is reflected acrosss the application

Returns `true` if successfully logged in and updated or `false` if the user can't be found in Core Data

**Usage:**
```swift
// This needs to be placed at the top view to be able to pass the context into the function
@Environment(\.managedObjectContext) var moc

// Needs to be in the view to pass into the constructor, and is generally an empty model on initial application login
@EnvironmentObject var profileModel: ProfileModel
...

// The user ID is attained on successful login to the firebase authentication
let loginUserResponse = ProfileDataMapperHelper(context: moc).loginUserProfile(profileModel: profileModel, uid: "userId")
```

#### signupUserProfileCreation

This creates a new user in Core data on account creation.

If there is a user there is a user with the matching ID already it returns `false` and does not create the user in core Data, however if there is no existing user it returns `true` and adds them to the Core Data tables.

**Usage:**
```swift
// This needs to be placed at the top view to be able to pass the context into the function
@Environment(\.managedObjectContext) var moc

// Needs to be in the view to pass into the constructor, and is generally an empty model on initial application login
@EnvironmentObject var profileModel: ProfileModel
...

// The user ID is attained on successful login to the firebase authentication
let loginUserResponse = ProfileDataMapperHelper(context: moc).signupUserProfileCreation(profileModel: profileModel, uid: "userId")
```