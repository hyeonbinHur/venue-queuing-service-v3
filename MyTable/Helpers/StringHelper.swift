//
//  StringExtensions.swift
//  MyTable
//
//  Created by Pascal Couturier on 12/10/2023.
//

import Foundation

/// Helper to convert and change various strings to other formats
struct StringHelper {
    
    // make into singleton
    static let shared = StringHelper()
    
    // There is a specific format for the date to be displayed as a string
    // so needed to convert between string and datetime
    /// Converts a string date to a `Date()` object
    /// - Parameter dateTime: `String` in the format of `"dd/MM/yy HH:mm"`
    /// - Returns: `Date()` object
    func stringToDateTime(dateTime: String) -> Date {
        var formattedDateTime: Date = Date()
        
        print("dateTime string: ", dateTime)
        
        if (!dateTime.isEmpty) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd/MM/yy HH:mm"
            formattedDateTime = dateFormatter.date(from: dateTime) ?? Date()
        }
        return formattedDateTime
    }
    
    // There is a specific format for the date to be displayed as a string
    // so needed to convert between string and datetime
    /// Converts a `Date()` object to a string value
    /// - Parameter dateTime: `Date()` object
    /// - Returns: `String` value in the format of `"dd/MM/yy EEE h:mm a"`
    func dateTimeToString(dateTime: Date) -> String {
        var formattedDateTime: String = ""
        
        print("Date object: ", dateTime)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yy EEE h:mm a"
        formattedDateTime = dateFormatter.string(from: dateTime)
        
        return formattedDateTime
    }
}
