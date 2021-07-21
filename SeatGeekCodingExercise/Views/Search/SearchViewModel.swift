//
//  SearchViewModel.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import Foundation

class SearchViewModel {
    
    private var events: [Event] = []
    let service = EventService()
    
    func searchForEvents(searchTerm: String, pagination: Bool, completion: ((Bool) -> Void)?) {
        service.fetchData(searchText: searchTerm) { result in
            switch result {
            case .success(let events):
                if pagination {
                    self.events.append(contentsOf: events)
                } else {
                    self.events = events
                }
                completion?(true)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion?(false)
            }
        }
    }
    
    func clearEvents() {
        events.removeAll()
    }
    
    func numberOfRows() -> Int {
        return events.count
    }
    
    func getEvent(byIndex index: Int) -> Event {
        return events[index]
    }
    
}

