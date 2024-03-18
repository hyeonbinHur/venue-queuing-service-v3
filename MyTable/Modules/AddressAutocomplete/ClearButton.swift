//
//  ClearButton.swift
//  MyTable
//
//  Created by Pascal Couturier on 3/10/2023.
//

// original code was attained from: https://github.com/maxkalik/address-autocomplete-swiftui
// Created by Maksim Kalik on 11/27/22.

import SwiftUI

/// clear button within the address text field to clear the address content
struct ClearButton: View {
    
    @Binding var text: String
    var viewModel: AddressAutocompleteViewModel
    
    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button {
                    text = ""
                    // also clear the address search results
                    viewModel.clearAddressResults()
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}
