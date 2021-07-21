//
//  SearchTableViewCell.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    let service = EventService()
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let event = event else { return }
        
        descriptionLabel.text = event.eventTitle
        locationLabel.text = event.venue.location
        dateAndTimeLabel.text = DateFormatter.twoLineDate(isoDate: event.dateAndTime)
        eventImageView.layer.cornerRadius = 4.0
        setFavoriteImage(EventController.shared.isFavoriteEvent(event: event))
        
        guard let imageString = event.performers.first?.image else { return }
        
        service.fetchImage(image: imageString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.eventImageView.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func setFavoriteImage(_ isFavorite: Bool) {
        let image = isFavorite ? UIImage(named: "heartRed") : nil
        favoriteImage.image = image
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        eventImageView.image = nil
        descriptionLabel.text = ""
        locationLabel.text = ""
        dateAndTimeLabel.text = ""
        favoriteImage.image = nil
    }
    
}
