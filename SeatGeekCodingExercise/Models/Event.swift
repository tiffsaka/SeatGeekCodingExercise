//
//  Event.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import Foundation

struct Event: Codable {
    
    struct Venue: Codable {
        let location: String
        
        enum CodingKeys: String, CodingKey {
            case location = "display_location"
        }
    }
    
    struct Performers: Codable {
        let image: String
    }
    
    let id: Int
    let dateAndTime: String
    let eventTitle: String
    let venue: Venue
    let performers: [Performers]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateAndTime = "datetime_local"
        case eventTitle = "short_title"
        case venue = "venue"
        case performers = "performers"
    }
    
}

struct EventsTopLevelObject: Codable {
        
    let events: [Event]
    
}

extension Event: Equatable {
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
}

