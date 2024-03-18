//
//  SearchPage.swift
//  my_table
//
//  Created by snlcom on 2023/08/14.
//

import SwiftUI

// TODO: add map view and functionality for map search to venu location
/// Search view where users can serach for venue locations
struct SearchView: View {
    //Test Core Data
    @Environment(\.managedObjectContext) var moc
    // Import the restaurant data
    @ObservedObject var restaurantData = LoadRestaurantData()
    
    @Binding var isTabViewVisible: Bool
    
    @State var searchResult: [RestaurantModel] = []
    @State var distanceResult: [RestaurantModel] = []
    @State var ratingResult: [RestaurantModel] = []
    @State var popularResult: [RestaurantModel] = []
    
    @State private var SearchText = ""
    
    @State var isButtonNearestSelected: Bool = false
    @State var isButtonTopReviewsSelected: Bool = false
    @State var isButtonPopularSelected: Bool = false
    
    
    // using this value to control production mode and in preview allow for preview mode
    var isPreviewMode: Bool = false
    
    var body: some View {
        VStack {
            Text("My Table")
                .font(.title.bold())
            SearchModule(isButtonNearestSelected: $isButtonNearestSelected,isButtonTopReviewsSelected: $isButtonTopReviewsSelected,isButtonPopularSelected: $isButtonPopularSelected)
            NavigationStack{
                if(!isButtonNearestSelected && !isButtonTopReviewsSelected &&
                   !isButtonPopularSelected){
                    List(searchResult) { restaurant in
                        NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                            RestaurantListItemModule(restaurant: restaurant)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    
                }else if(isButtonNearestSelected && !isButtonTopReviewsSelected && !isButtonPopularSelected){
                    List(distanceResult) { restaurant in
                        NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                            RestaurantListItemModule(restaurant: restaurant)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    
                }else if(!isButtonNearestSelected && isButtonTopReviewsSelected && !isButtonPopularSelected){
                    List(ratingResult) { restaurant in
                        NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                            RestaurantListItemModule(restaurant: restaurant)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    
                }else if(!isButtonNearestSelected && !isButtonTopReviewsSelected && isButtonPopularSelected){
                    List(popularResult) { restaurant in
                        NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                            RestaurantListItemModule(restaurant: restaurant)
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    
                }
            }
            .searchable(text: $SearchText)
            .onChange(of: SearchText){ SearchText in
                if !SearchText.isEmpty{
                    if(isButtonNearestSelected){
                        distanceResult = distanceResult.filter{$0.name.contains(SearchText)}
                    }else if(isButtonTopReviewsSelected){
                        ratingResult = ratingResult .filter{$0.name.contains(SearchText)}
                    }else if(isButtonPopularSelected){
                        popularResult = popularResult .filter{$0.name.contains(SearchText)}
                    }else{
                        searchResult = restaurantData.restaurants.filter{$0.name.contains(SearchText)}
                    }
                    
                    
                    
                }else{
                    searchResult = restaurantData.restaurants
                    distanceResult =  restaurantData.restaurants.sorted{$0.distance > $1.distance }
                    ratingResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
                    popularResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
                }
            }
            Spacer()
        }
        .onAppear {
            
            // MARK: added check as context doesn't come through in preview so set to null
            restaurantData.updateRestaurantsFromStoredData(context: isPreviewMode ? nil : moc)
            
            // Update values on appear
            searchResult = restaurantData.restaurants
            
            distanceResult =  restaurantData.restaurants.sorted{$0.distance > $1.distance }
            ratingResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
            popularResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isTabViewVisible: .constant(true), isPreviewMode: true)
            .environmentObject(LoadRestaurantData())
    }
}
