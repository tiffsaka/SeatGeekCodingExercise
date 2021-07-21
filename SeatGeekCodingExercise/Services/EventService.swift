//
//  EventService.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import UIKit

class EventService {
    
    let baseURL = URL(string: "https://api.seatgeek.com/2")
    let eventsComponent = "events"
    let apiClientKey = "client_id"
    let apiClientValue = "MjIzMzU3MTJ8MTYyNDQ4NDU2Ny4zNzAzNzEz"
    let perPageKey = "per_page"
    let perPageValue = "10"
    let pageKey = "page"
    var pageValue = 1
    let searchKey = "q"
    
    var isFetchingData = false
    
    func fetchData(searchText: String, pagination: Bool = false, completion: @escaping (Result<[Event], NetworkError>) -> Void) {
        guard !isFetchingData else {
            return
        }
        isFetchingData = true
        
        if !pagination {
            pageValue = 1
        }
        
        guard let baseURL = baseURL else {
            return completion(.failure(.invalidURL))
        }
        let eventsURL = baseURL.appendingPathComponent(eventsComponent)
        var components = URLComponents(url: eventsURL, resolvingAgainstBaseURL: true)
        let apiClientQuery = URLQueryItem(name: apiClientKey, value: apiClientValue)
        let perPageQuery = URLQueryItem(name: perPageKey, value: perPageValue)
        let pageQuery = URLQueryItem(name: pageKey, value: String(pageValue))
        let searchQuery = URLQueryItem(name: searchKey, value: searchText)
        
        components?.queryItems = [apiClientQuery, perPageQuery, pageQuery, searchQuery]
        
        guard let finalURL = components?.url else {
            return completion(.failure(.invalidURL))
        }
        print("Final URL: \(finalURL)")
        pageValue += 1
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            self.isFetchingData = false
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("DATA STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            do {
                let topLevel = try JSONDecoder().decode(EventsTopLevelObject.self, from: data)
                let events = topLevel.events
                completion(.success(events))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func fetchImage(image: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: image) else {
            return completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("IMAGE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let image = UIImage(data: data) else {
                return completion(.failure(.unableToDecode))
            }
            completion(.success(image))
        }.resume()
    }
    
}
