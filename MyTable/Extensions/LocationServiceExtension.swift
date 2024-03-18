//
//  LocationServiceExtensions.swift
//  MyTable
//
//  Created by Pascal Couturier on 24/9/2023.
//

import CoreLocation

/// Create an extension to make CLLocationCoordinate2D conform to Equatable
/// Needing this extension so that we can use the filter by region center in the MapModule
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
