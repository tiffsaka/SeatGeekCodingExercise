//
//  EventController.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import Foundation

class EventController {
    
    static let shared = EventController()
    var favoriteEvents: [Int] = []

    func isFavoriteEvent(event: Event) -> Bool {
        return favoriteEvents.contains(event.id)
    }
    
    func addEventToFavorites(event: Event) {
        favoriteEvents.append(event.id)
        print("Favorite event added")
        saveToPersistenceStore()
    }
    
    func removeEventFromFavorites(event: Event) {
        guard let index = favoriteEvents.firstIndex(of: event.id) else { return }
        favoriteEvents.remove(at: index)
        print("Favorite event removed")
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    
    private func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Events.json")
        return fileURL
    }
    
    private func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(favoriteEvents)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            favoriteEvents = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}

