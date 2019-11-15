//
//  foursquaredishTests.swift
//  foursquaredishTests
//
//  Created by Tia Lendor on 11/5/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import XCTest
@testable import foursquaredish

class foursquaredishTests: XCTestCase {

    func testVenueDataFromJSON () {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "Venue", ofType: "json")
            else { XCTFail(); return }
        let url = URL (fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            guard let venueData = try VenueResult.getVenues(from: data) else {
                XCTFail(); return}
            XCTAssert(venueData.count > 0)

        } catch {
            XCTFail()
            print(error)
        }
        
    }

}
