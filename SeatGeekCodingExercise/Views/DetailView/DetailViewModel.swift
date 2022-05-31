//
//  DetailViewModel.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import UIKit

class DetailViewModel {
    
    let event: Event
    let service = EventService()
    var eventImage = UIImage()
    let cornerRadius = 5.0

    init(event: Event) {
        self.event = event
    }
    
    func oneLineFormattedDate() -> String {
        DateFormatter.oneLineDate(isoDate: event.dateAndTime)
    }
    
    func isFavoriteBool(event: Event) -> Bool {
        EventController.shared.isFavoriteEvent(event: event)
    }
    
    func getFavoriteButtonImageName(isFavorite: Bool) -> String {
        isFavorite ? "heartRed" : "heartEmpty"
    }
    
    func fetchImage(completion: ((Bool) -> Void)?) {
        guard let image = event.performers.first?.image else { return }
        
        service.fetchImage(image: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.eventImage = image
                    completion?(true)
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    completion?(false)
                }
            }
        }
    }
    
}

