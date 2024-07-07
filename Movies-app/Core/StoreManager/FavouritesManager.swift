//
//  FavouritesManager.swift
//  Movies-app
//
//  Created by Tatarella on 05.07.24.
//

import Foundation

protocol FavouritesManagerDelegate: AnyObject{
    func favoritesDidUpdate()
}

class FavouritesManager {
    
    static let shared = FavouritesManager()
    weak var delegate: FavouritesManagerDelegate?
    
        private let userDefaultsKey = "favorites"
        
        var items: [FavoriteItem] = [] {
            didSet {
                saveItems()
                delegate?.favoritesDidUpdate()
            }
        }

        private init() {
            self.items = loadItems()
        }
        
        private func saveItems() {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: userDefaultsKey)
            }
        }
        
        private func loadItems() -> [FavoriteItem] {
            if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
               let items = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
                return items
            }
            return []
        }

        func toggleItem(_ item: FavoriteItem) {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: index)
            } else {
                items.append(item)
            }
        }

        func isFavorite(_ id: Int) -> Bool {
            return items.contains { $0.id == id }
        }
}
