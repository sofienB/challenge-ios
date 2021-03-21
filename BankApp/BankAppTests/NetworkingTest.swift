//
//  NetworkingTest.swift
//  BankAppTests
//
//  Created by sofien Benharchache on 21/03/2021.
//

import XCTest
@testable import BankApp

class NetworkingTest: XCTestCase {
    private var networkManager: NetworkManager!

    override func setUpWithError() throws {
        self.networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
    }

    func testFetchBanks() throws {
        networkManager.fetchBanks() { banks, error in
            if error != NetworkResponse.success {
                print(error.debugDescription)
            } else {
                XCTAssertEqual(error, NetworkResponse.success)
                XCTAssertNotNil(banks)
            }
        }
    }
    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
