//
//  MainPage.swift
//  my_table
//
//  Created by snlcom on 2023/08/14.
//

import SwiftUI
import CoreData

/// Main view that is displayed to the user after successful login or signup
struct MainView: View {
    //Test Core Data
    @Environment(\.managedObjectContext) var moc
    // Import the restaurant data
    @ObservedObject var restaurantData = LoadRestaurantData()
    
    @Binding var isTabViewVisible: Bool
    
    @State var isButtonNearestSelected: Bool = false
    @State var isButtonTopReviewsSelected: Bool = false
    @State var isButtonPopularSelected: Bool = false
    
    @State var searchResult: [RestaurantModel] = []
    @State var distanceResult: [RestaurantModel] = []
    @State var ratingResult: [RestaurantModel] = []
    @State var popularResult: [RestaurantModel] = []
    
    // using this value to control production mode and in preview allow for preview mode
    var isPreviewMode: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("My Table")
                    .font(.title.bold())
                
                VStack(alignment: .leading){
                    SearchModule(isButtonNearestSelected: $isButtonNearestSelected,isButtonTopReviewsSelected: $isButtonTopReviewsSelected,isButtonPopularSelected: $isButtonPopularSelected)
                    
                    if(!isButtonNearestSelected && !isButtonTopReviewsSelected &&
                       !isButtonPopularSelected){
                        
                        List(restaurantData.restaurants) { restaurant in
                            NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                                RestaurantListItemModule(restaurant: restaurant)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .scrollContentBackground(.hidden)
                    }else if(isButtonNearestSelected && !isButtonTopReviewsSelected && !isButtonPopularSelected){
                        Text("Nearest tables to you")
                            .font(.title2)
                            .padding(.bottom, 0)
                            .padding(.leading, 20)
                        List(distanceResult) { restaurant in
                            NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                                RestaurantListItemModule(restaurant: restaurant)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .scrollContentBackground(.hidden)
                    }else if(!isButtonNearestSelected && isButtonTopReviewsSelected && !isButtonPopularSelected){
                        Text("Top Review Place")
                            .font(.title2)
                            .padding(.bottom, 0)
                            .padding(.leading, 20)
                        List(ratingResult) { restaurant in
                            NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                                RestaurantListItemModule(restaurant: restaurant)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .scrollContentBackground(.hidden)
                    }else if(!isButtonNearestSelected && !isButtonTopReviewsSelected && isButtonPopularSelected){
                        Text("Most Popular Place")
                            .font(.title2)
                            .padding(.bottom, 0)
                            .padding(.leading, 20)
                        List(popularResult) { restaurant in
                            NavigationLink(destination: RestaurantView(restaurant: restaurant, isTabViewVisible: $isTabViewVisible)) {
                                RestaurantListItemModule(restaurant: restaurant)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .scrollContentBackground(.hidden)
                    }
                    
                    
                    // Restaurant list section
                    
                    // Restaurants list
                    // They are navigation links and when clicked load the restaurant details page with their content
                    
                    
                }
                // Need this to account for the Tab View on the ContentView
                // so it doesn't overlap
                .padding(.bottom, 15)
            }
            .onAppear {
                
                // MARK: added check as context doesn't come through in preview so set to null
                restaurantData.updateRestaurantsFromStoredData(context: isPreviewMode ? nil : moc)
                
                // Update values on appear
                distanceResult =  restaurantData.restaurants.sorted{$0.distance > $1.distance }
                ratingResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
                popularResult =  restaurantData.restaurants.sorted{$0.rating > $1.rating }
            }
        }
    }
    // TODO: Create restaurant builder that loads from restaurant object
    // https://stackoverflow.com/questions/61188614/swiftui-navigate-to-different-view-from-list
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        
        return TabView {
            MainView(isTabViewVisible: .constant(true), isPreviewMode: true)
                .environmentObject(LoadRestaurantData())
        }
    }
}
