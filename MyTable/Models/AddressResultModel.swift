//
//  AddressResultModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 3/10/2023.
//

// original code was attained from: https://github.com/maxkalik/address-autocomplete-swiftui
// Created by Maksim Kalik on 11/27/22.

import Foundation

/// The response from the address autocomplete module to render to users in the drop down
struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}
