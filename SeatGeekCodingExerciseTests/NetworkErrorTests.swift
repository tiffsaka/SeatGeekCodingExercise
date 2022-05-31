//
//  NetworkErrorTests.swift
//  SeatGeekCodingExerciseTests
//
//  Created by Tiffany Sakaguchi on 5/30/22.
//

import XCTest
@testable import SeatGeekCodingExercise

class NetworkErrorTests: XCTestCase {
    
    var error: NetworkError { .invalidURL }

    func test_NetworkErrorEnum_invalidCredentials() {
        let result = error
        XCTAssertEqual(result, .invalidURL)
    }
    
    func test_NetworkErrorEnum_invalidCredentialsErrorDescription() throws {
        let result = error
        XCTAssertEqual(result.errorDescription, "Unable to reach the server.")
    }
    
}
