//
//  AddressAutocompleteModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 3/10/2023.
//

// original code was attained from: https://github.com/maxkalik/address-autocomplete-swiftui
// Created by Maksim Kalik on 11/27/22.

import SwiftUI
import MapKit

/// Address autocomplete module that is a text field and can populate a dropdown list based on search responses to the address text input
struct AddressAutocompleteModule: View {
    
    @StateObject var viewModel = AddressAutocompleteViewModel()
    @State private var isFocusedTextField: Bool = false
    // Pass through the bound values from the parent model to be updated by the address search
    @Binding var fullAddress: String
    @Binding var longitude: Double
    @Binding var latitude: Double
    @Binding var showList: Bool

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                TextField("", text: $viewModel.searchableText)
                    .autocorrectionDisabled()
                    .onTapGesture {
                        isFocusedTextField = true // Focus when the user taps on the text field
                    }
                    .onReceive(
                        viewModel.$searchableText.debounce(
                            for: .seconds(1),
                            scheduler: DispatchQueue.main
                        )
                    ) {
                        viewModel.searchAddress($0)
                        showList = !$0.isEmpty
                    }
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("InputGrey"))
                    )
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .overlay {
                        ClearButton(text: $viewModel.searchableText, viewModel: viewModel)
                            .padding(.trailing, 40)
                            .padding(.top, 3)
                    }
                    .onChange(of: showList) {newValue in
                        print("new value: \(newValue)")
                    }
                if (isFocusedTextField && showList) {
                    List(self.viewModel.results) { address in
                        VStack(alignment: .leading) {
                            Text(address.title)
                            Text(address.subtitle)
                                .font(.caption)
                        }
                        .padding(.bottom, 2)
                        .listRowBackground(backgroundColor)
                        .onTapGesture {
                            selectAddress(address: address)
                            isFocusedTextField = false
                            showList = false
                        }
                    }
                    .frame(height: 350)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            if (!fullAddress.isEmpty) {
                viewModel.searchableText = fullAddress
            }
        }
    }
    
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
}

struct AddressAutocompleteModule_Previews: PreviewProvider {
    static var previews: some View {
        AddressAutocompleteModule(viewModel: AddressAutocompleteViewModel(), fullAddress: .constant("12 Acland St, St Kilda, VIC, Australia"), longitude: .constant(144.9753939), latitude: .constant(-37.8629134), showList: .constant(false))
    }
}

extension AddressAutocompleteModule {
    // update address on select and clear list
    
    /// Updates values and creates the address String after the address is selected
    /// - Parameter address: `AddressResult` from the address dropdown select
    func selectAddress(address: AddressResult) {
        viewModel.searchableText = address.subtitle.contains(address.title) ? address.subtitle : address.title + ", " + address.subtitle
        viewModel.clearAddressResults()
        
        // update the passed in bound addres to match
        fullAddress = viewModel.searchableText
        
        print("\(fullAddress)")
        print("selected address: \(viewModel.searchableText)")
        
//        update geolocation points
        getAnnotatedItemFromAddress(location: fullAddress)
        
        showList = false
    }
    
    // TODO: make this into a globally sharable function as it is used within the maps as well
    // Returns the AnnotatedItem from a string address passed through
    /// Gets the longitude and latitude of the address from the address string
    /// - Parameter location: `String` the address string value
    private func getAnnotatedItemFromAddress(location: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                return
            }
            
            
            print("longitude: \(location.coordinate.longitude)")
            print("latitude: \(location.coordinate.latitude)")
            
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
}
