//
//  ContentView.swift
//  MyTable
//
//  Created by snlcom on 2023/08/12.
//
//  
import SwiftUI
/// The main view for the application
struct ContentView: View {
    //Test Core Data
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var customers: FetchedResults<Customer>
    @FetchRequest(sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    @FetchRequest(sortDescriptors: []) var reservations: FetchedResults<Reservation>
    @State private var showingaddres: Bool = false
    @State private var test: Bool = false
    
    
    // Binding for profile
    @EnvironmentObject var profileModel: ProfileModel
    @EnvironmentObject var authModel: AuthenticationModel
    // Restaurant Profile Object
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    
    // State variable for controlling the tabView
    @State var isTabViewVisible = true
    @State var watingUsersArray: [String] = []
    var body: some View {
        
        if(test){
//            validationView(numberOfFields: 5,isEditing: .constant(true))
            
            Button("DATA check toogle button"){
                showingaddres.toggle()
            }
            .padding(10)
            if(showingaddres){
                DataModelCreationTest(isPresent: .constant(false))
            }else{
                DataModelRUDTest()
            }
            
//            TabView{
//                MainView(isTabViewVisible: .constant(true))
//                    .tabItem{
//                        Image(systemName: "house")
//                        Text("Home")
//                    }
//                SearchView(isTabViewVisible: .constant(true))
//                    .tabItem{
//                        Image(systemName: "magnifyingglass")
//                        Text("Search")
//                    }
//                ReservationsView()
//                    .tabItem{
//                        Image(systemName: "calendar")
//                        Text("Reservations")
//                    }
//                ProfileView()
//                    .tabItem{
//                        Image(systemName: "person.fill")
//                        Text("Profile")
//                    }
//
//            }
//            .environmentObject(AuthenticationModel())
//            .environmentObject(ProfileModel())
            
            
        }else{
            VStack {
                // Check to see if the profile is logged in or is the authentication user
                // is stored in state to not have to login again
                if (profileModel.isLoggedIn || authModel.user != nil) {
                    
                    // Show this restaurant details module After initial signin/signup if the user
                    // has not entered it before and there is no data found for the restaurant
                    // only applicable if:
                    // - it is a venue
                    // - there is a logged in user with userId
                    // - there is no restaurantProfileModel data loaded
                    
                    if (profileModel.isVenue && restaurantProfileModel.venueId.isEmpty) {
                        SignupRestaurantDetailsModule()
                            .onAppear {
                                // load user profile if authModel.user is present
                                updateProfileIfAlreadyLoggedIn()
                            }
                    } else {
                        // TODO: Hide tabView when on restaurant page
                        // https://stackoverflow.com/questions/69771595/how-to-hide-tabview-navigating-from-tabitem-in-childview-in-swiftui
                        TabView{
                            if (isTabViewVisible) {
                                MainView(isTabViewVisible: $isTabViewVisible)
                                    .tabItem{
                                        Image(systemName: "house")
                                        Text("Home")
                                    }
                                if (profileModel.isVenue) {
                                    
//                                    RestaurantQueue(watingUsersArray: $watingUsersArray)
//                                        .tabItem {
//                                            Image(systemName: "person.2.fill")
//                                            Text("Queue")
//                                        }
                                } else {
                                    SearchView(isTabViewVisible: $isTabViewVisible)
                                        .tabItem{
                                            Image(systemName: "magnifyingglass")
                                            Text("Search")
                                        }
                                }
                                MapView()
                                    .tabItem{
                                        Image(systemName: "map")
                                        Text("Map")
                                    }
                                ProfileView()
                                    .tabItem{
                                        Image(systemName: "person.fill")
                                        Text("Profile")
                                    }
                            }
                            
                        }
                        .onAppear {
                            
                            // load user profile if authModel.user is present
                            updateProfileIfAlreadyLoggedIn()
                        }
                    }
                } else {
                    AuthenticationModule()
                }
            }
            .onAppear {
                authModel.listenToAuthState()
                
            }
        }
        
        // Need to have the VStack wrapper around everything so that the authModel listener is triggered on appear
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            MainView(isTabViewVisible: .constant(true), isPreviewMode: true)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView(isTabViewVisible: .constant(true), isPreviewMode: true)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            MapView()
                .tabItem{
                    Image(systemName: "map")
                    Text("Map")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
        .environmentObject(AuthenticationModel())
        .environmentObject(ProfileModel())
    }
}

extension ContentView {
    
    // need method to load the profileModel data if the authmodel is already logged in
    // otherwise the user is authenticated but it hasn't fetched the data to add to the model
    /// If the user is already logged in then it allows for them not to have to login again and gets their data from the core data store
    func updateProfileIfAlreadyLoggedIn() {
        // if the user is already logged in the authModel will still hold the users details and uid
        if (authModel.user != nil || !profileModel.userId.isEmpty) {
            ProfileDataMapperHelper(context: moc).loginUserProfile(profileModel: profileModel, uid: authModel.user?.uid ?? profileModel.userId)
            
            // after user details are updated then change profile value to logged in
            profileModel.isLoggedIn = true
            
            // Check if it's a venue and load venue data if it is
            if (profileModel.isVenue) {
                RestaurantProfileDataMapperHelper(context: moc).loadRestaurantProfileModel(restaurantProfileModel: restaurantProfileModel, userId: profileModel.userId)
            }
        }
    }
}
