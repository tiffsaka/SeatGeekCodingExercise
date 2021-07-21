//
//  DateFormatter.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import Foundation

extension DateFormatter {
    
    static func oneLineDate(isoDate: String) -> String {
        dateFormatterHelper(isoDate: isoDate, dateFormat: "EEEE, d MMM yyyy h:mm a")
    }
    
    static func twoLineDate(isoDate: String) -> String {
        dateFormatterHelper(isoDate: isoDate, dateFormat: "EEEE, d MMM yyyy\nh:mm a")
    }
    
    static func dateFormatterHelper(isoDate: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let updatedDateFormatter = DateFormatter()
        updatedDateFormatter.dateFormat = dateFormat
        
        guard let date = dateFormatter.date(from: isoDate) else { return "No Date"}
        
        let dateString = updatedDateFormatter.string(from: date)
        return dateString
    }
    
}
