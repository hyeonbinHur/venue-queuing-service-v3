# Restaurant Profile Data Mapper Helper

This helper assists with mapping the restaurant profile data between the storage (Core Data) and the application.

## Overview

Having this helper or service allows formapping data to the models that the application can understand. 

This is particularly important for situations where we may change the data source, i.e. changing from Core Data store to an SQL database for example. we don't need to adjust all the implementations throughout the project, we just update the mapping fields in the mapping helper.

Restaurant venues have both the Profile mapping as well as the restaurant profile, this is due to the login credentials are for the profile and the restaurant profile is to manage all the details of the restaurant itself.

### Usage Examples

There are some methods in this that are to be used only within it, so we will focus on the usable ones.

#### loadOrCreateRestaurantProfileModel

This loads or creates the restaurant data in the Core Data Storage and is used for Signup.

The venueId is currently the same value as the logged in UserId profile to match them, this needs to be adjusted down the track

Returns `true` if the restaurant is loaded and `false` if the restaurant is created

**Usage:**
```swift
// we are needing thes variables to be able to interact and update the required fields
// managed object to access store
@Environment(\.managedObjectContext) var moc
// Binding for profile
@EnvironmentObject var profileModel: ProfileModel
// Restaurant Profile Object
@EnvironmentObject var restaurantProfileModel: RestaurantProfileModel

...

RestaurantProfileDataMapperHelper(context: moc).loadOrCreateRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, userId: profileModel.userId)
```

#### loadRestaurantProfileModel

This loads the restaurant profile data and is usually done on initial load after login if the user profile comes back stating that they are a venue.

Returns `true` if the restaurant is loaded and `false` if there is no matching venueId found

**Usage:**
```swift
// we are needing thes variables to be able to interact and update the required fields
// managed object to access store
@Environment(\.managedObjectContext) var moc
// Binding for profile
@EnvironmentObject var profileModel: ProfileModel
// Restaurant Profile Object
@EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
...

RestaurantProfileDataMapperHelper(context: moc).loadRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, userId: profileModel.userId)
```