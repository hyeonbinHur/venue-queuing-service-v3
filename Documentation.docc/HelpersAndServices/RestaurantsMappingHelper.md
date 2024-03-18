# Restaurants Mapping Helper

This helper assists with mapping the restaurant data between the storage (Core Data) and the application. This is for the front end visual representation of the restaurants to the users

## Overview

Having this helper or service allows formapping data to the models that the application can understand. 

This is particularly important for situations where we may change the data source, i.e. changing from Core Data store to an SQL database for example. we don't need to adjust all the implementations throughout the project, we just update the mapping fields in the mapping helper.

This model is used whenever the restaurant is being displayed to the users of the application as it only holds those required values and not all the content that the RestaurantProfileModel may contain to manage all restaurant details.

### Usage Examples

We will be focusing on the functions that are used within the views directly

#### getRestaurants

Returns a list of all the restaurants from Core Data storage to display to the user

**Usage:**
```swift
// needs to have context passed through to it: context: NSManagedObjectContext
// if used in a view it should have `@Environment(\.managedObjectContext) var moc` at the top of the view and pass `moc` in replacement for `context` below
let restaurantsFromCoreData = RestaurantsMappingHelper(context: context!).getRestaurants()
```

#### getStoredRestaurantByVenueId

This gets the stored restaurant by the venuId and returns the restaurant model from the core data, not the model to be displayed to the user

**Usage:**
```swift
// needs to have access to the NSManagedObjectContext
var restaurantData = getStoredRestaurantByVenueId(venueId: "venueId", in: self.moc)
```