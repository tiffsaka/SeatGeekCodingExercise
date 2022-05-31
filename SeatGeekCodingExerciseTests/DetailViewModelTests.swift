//
//  DetailViewModelTests.swift
//  SeatGeekCodingExerciseTests
//
//  Created by Tiffany Sakaguchi on 5/29/22.
//

import XCTest
@testable import SeatGeekCodingExercise

class DetailViewModelTests: XCTestCase {

    private var sut: DetailViewModel!

    let event = Event(id: 123,
                      dateAndTime: "dateString",
                      eventTitle: "eventString",
                      venue: Event.Venue(location: "eventLocation"),
                      performers: [Event.Performers(image: "imageString")])
    
    override func setUp() {
        super.setUp()
        sut = DetailViewModel(event: event)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getFavoriteButtonImageName() {
        XCTAssertEqual(sut.getFavoriteButtonImageName(isFavorite: false), "heartEmpty")
        XCTAssertEqual(sut.getFavoriteButtonImageName(isFavorite: true), "heartRed")
    }
    
}
