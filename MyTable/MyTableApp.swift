//
//  MyTableApp.swift
//  MyTable
//
//  Created by Pascal Couturier on 6/8/2023.
//

import SwiftUI
import Firebase

@main
struct MyTableApp: App {
    // Load the user profile data object template
    @StateObject var profileModel = ProfileModel()
    @StateObject var restaurantProfileModel = RestaurantProfileModel() // Default model details if the logged in user is a restaurant creates a blank empty object
    
    // Firebase setup guide:
    // https://www.youtube.com/watch?v=9lvHcqF5ZQ4&list=PLvwL6qncCpUSvcXbvB-NdFj0JPLa18Nbo&index=2
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(AuthenticationModel())
                .environmentObject(profileModel)
                .environmentObject(restaurantProfileModel)
                .preferredColorScheme(.light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
