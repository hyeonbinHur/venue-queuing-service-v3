# MapModule

@Metadata {
    @PageImage(
        purpose: icon, 
        source: "map-module-screenshot", 
        alt: "Map module image for page icons")
    @PageColor(green)
}

The original concept for the map and annotations were attained from Week 9 Lecture - Shekhar Kalra (Presented in lecture as demonstartion)

In order to display restaurants within the application we have created a custom Map Component that allows for various parameters so the same component can be used in multiple places to reduce duplicate map code.

## Overview

At first glance it appears like a standard map within the application and can displat various points of interest via `annotatedItems`.

![map module screenshot](map-module-screenshot)

The map can be used to display a single point of interest, for example when looking up a single venue, it will display a single point and have the region shown for that restaurant. 
However it can also set the region and display multiple points of interest, such as when searching for a loction and venues close by.

In order to make this component reusable it does not directly access any `environmentObjects` or models (such as customer or venue models), it has the values passed through to it and uses them.
The map doesn't edit any data sent to it, it simply displays the data provided to it.

### Parameters

The parameters that are used are:
- `location` => `String` -  If only the location is passed through then it shows that single location on the map and uses it for the region, generally used when wanting to display a single venue
- `interactionMode` -> Can set if the map can be interacted with, by default it's all adjustable and set as `.all`
  - Options are:
    - `.pan`
    - `.zoom`
    - `.all`
- `venueAddresses` => `(String Array)` - if there are values in here then it uses these string address values to render the annotations on the map and the `location` above to set the region - MUST be used with `location`
- `restaurantModelList` => `(Array of RestaurantModel)` - if provided, then it uses the longitude and latitude of each restaurant to display them on the map

 `location` MUST be provided when searching for single venue or using the  `venueAddresses` string array, if not provided when passing the `restaurantModelList` array through then the region is set to the location of the first restaurant in the list

### Usage Examples

- **Location Only**
  - Single point of interest

```swift
MapModule(location: "1 Acland Street, St Kilda, Melbourne")
```

- **Location and Multiple Address Points**
  - location and multiple venues provided as an array of full string addresses

```swift
MapModule(location: "1 Acland Street, St Kilda, Melbourne", venueAddresses: ["1 Acland Street, St Kilda, Melbourne", "5 Acland Street, St Kilda, Melbourne", "6 Acland Street ,St Kilda, Melbourne"])
```

- **Location and Restaurant Model**
  - this is when the restaurant object is passed through as it has it's own longitude and latitude in the model to define the annotation items to display on the map

```swift
let restaurant1 = RestaurantModel(venueId: UUID().uuidString, name: "testing name", slug: "testing slug", cuisine: "italian", image: "", distance: 1.0, rating: 4.0, phone: "0400000000", websiteUrl: "http://#", menuUrl: "#", featuredImages: [], latitude: -37.813629, longitude: 144.963058, numOfQueue: 0, inQueue: [])
        
        
MapModule(location: "1 Acland Street, St Kilda, Melbourne", restaurantModelList: [restaurant1])
```
