//
//  BALocation.swift
//  BankAppTests
//
//  Created by sofien Benharchache on 21/03/2021.
//

import XCTest
@testable import BankApp

class BALocationTests: XCTestCase {
    let locationKey = "bank.app.current.location"
    override func setUpWithError() throws {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: locationKey) != nil {
            defaults.removeObject(forKey: locationKey)
            defaults.synchronize()
        }
    }

    override func tearDownWithError() throws {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: locationKey) != nil {
            defaults.removeObject(forKey: locationKey)
            defaults.synchronize()
        }
    }

    func testLocationFromLocal() throws {
        BALocation().locationFromLocal()
        let location: String? = UserDefaults.standard.object(forKey: locationKey) as! String
        let expectedLocation = "en"
        XCTAssertEqual(location, expectedLocation)
    }
    
    func testNilLocationFromLocal() throws {
        let location: String? = UserDefaults.standard.object(forKey: locationKey) as? String
        XCTAssertNil(location)
    }

    func testFormatCountry() throws {
        let england = BALocation.getCountry(from: "en".uppercased())
        
        XCTAssertEqual(england, "England")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
