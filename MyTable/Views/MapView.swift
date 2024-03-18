//
//  MapView.swift
//  MyTable
//
//  Created by Pascal Couturier on 12/10/2023.
//

import SwiftUI

/// This is the map view that can have address searches and display content on the map based on location and points of interest
struct MapView: View {
    // get access to core data
    @Environment(\.managedObjectContext) var moc
    // Import the restaurant data
    @ObservedObject var restaurantData = LoadRestaurantData()
    
    // address autocomplete
    @State var fullAddress: String = ""
    @State var longitude: Double = 0.0
    @State var latitude: Double = 0.0
    
    @State var showAddressAutocompleteList: Bool = false
    
    @State var isPreviewMode = false
    
    var body: some View {
        VStack {
            
            Text("My Table")
                .font(.title.bold())
            ZStack {
                MapModule(location: $fullAddress, restaurantModelList: restaurantData.restaurants)
                    .padding(.top, 100)
                AddressAutocompleteModule(fullAddress: $fullAddress, longitude: $longitude, latitude: $latitude, showList: $showAddressAutocompleteList)
            }
            Spacer()
        }
        .onAppear {
            // MARK: added check as context doesn't come through in preview so set to null
            restaurantData.updateRestaurantsFromStoredData(context: isPreviewMode ? nil : moc)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
