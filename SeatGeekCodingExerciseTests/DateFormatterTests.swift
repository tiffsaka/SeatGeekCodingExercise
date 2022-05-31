//
//  DateFormatterTests.swift
//  SeatGeekCodingExerciseTests
//
//  Created by Tiffany Sakaguchi on 5/30/22.
//

import XCTest
@testable import SeatGeekCodingExercise

class DateFormatterTests: XCTestCase {
    
    private var sut: DateFormatter!
    private var isoDate: String = ""
    
    override func setUp() {
        super.setUp()
        sut = DateFormatter()
        isoDate = "2021-07-15T23:30:00"
    }
    
    override func tearDown() {
        sut = nil
        isoDate = ""
        super.tearDown()
    }
    
    func test_oneLineDate() {
        XCTAssertEqual(DateFormatter.oneLineDate(isoDate: isoDate), "Thursday, 15 Jul 2021 11:30 PM")
    }
    
    func test_twoLineDate() {
        XCTAssertEqual(DateFormatter.twoLineDate(isoDate: isoDate), "Thursday, 15 Jul 2021\n11:30 PM")
    }
    
    func test_invalidDate() {
        XCTAssertEqual(DateFormatter.oneLineDate(isoDate: "invalidDateString"), "No Date")
    }
    
    func test_emptyDate() {
        XCTAssertEqual(DateFormatter.oneLineDate(isoDate: ""), "No Date")
    }
    
}
