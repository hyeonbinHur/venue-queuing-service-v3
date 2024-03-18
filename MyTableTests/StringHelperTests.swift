//
//  StringHelperTests.swift
//  MyTableTests
//
//  Created by Pascal Couturier on 14/10/2023.
//

import XCTest

@testable import MyTable

/// Testing the various String helpers that converts to or from various string values
final class StringHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    /// Testing that a specific string format can be converted to a date format
    func testStringToDateTimeConversion() {
        // Set a date by default as a string value
        let dateAsString = "31/08/2023 12:30"
        
        // Use the converter to change to an actual date
        let convertedDate = StringHelper.shared.stringToDateTime(dateTime: dateAsString)
        
        // use the converter to change the date back to a string
        let revertedDateToString = StringHelper.shared.dateTimeToString(dateTime: convertedDate)
        // Check that the returned string is matching the expected format to be used in the project
        XCTAssertEqual(revertedDateToString, "31/08/23 Thu 12:30 PM")
    }
}
