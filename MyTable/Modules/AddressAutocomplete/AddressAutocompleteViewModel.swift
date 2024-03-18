//
//  AddressAutocompleteViewModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 3/10/2023.
//

// original code was attained from: https://github.com/maxkalik/address-autocomplete-swiftui
// Created by Maksim Kalik on 11/27/22.

import Foundation
import MapKit

/// the address view model controls the searching and responses for the address dropdown
class AddressAutocompleteViewModel: NSObject, ObservableObject {
    
    @Published private(set) var results: Array<AddressResult> = []
    @Published var searchableText = ""

    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    /// Address search query to get list
    /// - Parameter searchableText: the text entered into the address inout field
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func clearAddressResults() {
        results = []
    }
}

extension AddressAutocompleteViewModel: MKLocalSearchCompleterDelegate {
    /// Updates the list with the `AddressResults` data
    /// - Parameter completer: `AddressResults` list
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
