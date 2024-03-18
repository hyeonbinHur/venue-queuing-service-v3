# Address Autocomplete Module

@Metadata {
    @PageImage(
        purpose: icon, 
        source: "autocomplete-open", 
        alt: "Address Autocomplete")
    @PageColor(green)
}

The address autocomplete is an adjustment of an existing SwiftUI autocomplete code by Maksim Kalik and allows for searching up addresses and populating a dropdown list to present to the user.

## Overview

The address autocomplete is an adjustment of an existing SwiftUI autocomplete code by Maksim Kalik (<a href="https://github.com/maxkalik/address-autocomplete-swiftui" target="_blank">https://github.com/maxkalik/address-autocomplete-swiftui</a>).

We have customised it in our solution by editing the style, the conditional rendering and also to populate particular values being passed through.

In our app we want to be able to have an address edit details section that uses real addresses from a lookup and this could be used for either customer, restaurant, or any other potential usage.

### Implementation

The original implementation is for the address update for the restaurant profile:
![Autocomplete Image](restaurant-address-field-profile)

This field can be placed in any form and when the address is entered it does a local search to find any matching addresses and a dropdown is displayed to the user.

On selecting the address from the dropdown it updates the `fullAddress` of the provided bound value as well as the `longitude` and `latitude` of the address location which can be used for `annotatedItems` to display as positions on a map.

![address autocomplete  open](autocomplete-open)

### Parameters

It can be used by instantiating it with 3 values:
- `fullAddress` => A String value
- `longitude` => Boolean value
- `latitude` => Boolean value

And these values are bound to the model that is passed through to it in order to keep the state. An example of this is the restaurantModel can be broken up and passed into it and then it changes in the autocmplete it updates the model for the restaurant directly.

### Usage Example

The usage in the `EditRestaurantProfile` is below:

```swift
AddressAutocompleteModule(fullAddress: $restaurantProfileModel.fullAddressString, longitude: $restaurantProfileModel.longitude, latitude: $restaurantProfileModel.latitude)
```

This allows for it to be reusable and not only having the usage for restaurants
