//
//  DetailViewController.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoritedButton: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        updateViews()
    }
    
    func configOnSegue(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func updateViews() {
        viewModel.fetchImage { success in
            if success {
                self.eventImageView.image = self.viewModel.eventImage
                self.eventImageView.layer.cornerRadius = 5.0
            }
        }
        descriptionLabel.text = viewModel.event.eventTitle
        dateAndTimeLabel.text = DateFormatter.oneLineDate(isoDate: viewModel.event.dateAndTime)
        locationLabel.text = viewModel.event.venue.location
        
        let event = viewModel.event
        let isFavoriteBool = EventController.shared.isFavoriteEvent(event: event)
        setFavoriteButton(isFavoriteBool)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoritedButtonTapped(_ sender: Any) {
        print("Favorite button tapped")
        let event = self.viewModel.event
        if EventController.shared.isFavoriteEvent(event: event) {
            EventController.shared.removeEventFromFavorites(event: event)
        } else {
            EventController.shared.addEventToFavorites(event: event)
        }
        setFavoriteButton(EventController.shared.isFavoriteEvent(event: event))
    }
    
    func setFavoriteButton(_ isFavorite: Bool) {
        let imageName = isFavorite ? "heartRed" : "heartEmpty"
        favoritedButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
}

