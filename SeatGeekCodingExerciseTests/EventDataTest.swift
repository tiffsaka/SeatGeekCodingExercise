//
//  EventDataTest.swift
//  SeatGeekCodingExerciseTests
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import XCTest
@testable import SeatGeekCodingExercise

class EventDataTest: XCTestCase {

    func testCanParseEvents() throws {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "SeatGeekSampleResponse", ofType: "json") else { fatalError("json file was not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8)
        else {
            fatalError("Not able to convert json to String")
        }
        
        let data = json.data(using: .utf8)!
        let eventData = try!
            JSONDecoder().decode(EventsTopLevelObject.self, from: data)
    
        XCTAssertEqual(5396718, eventData.events[0].id)
        XCTAssertEqual("Toronto Argonauts at Montreal Alouettes", eventData.events[0].eventTitle)
        
    }

}
