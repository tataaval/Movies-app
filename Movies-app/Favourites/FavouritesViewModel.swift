//
//  FavouritesViewModel.swift
//  Movies-app
//
//  Created by Tatarella on 05.07.24.
//

import Foundation

protocol FavouritesViewModelType {
    var input: FavouritesViewModelInput { get }
    var output: FavouritesViewModelOutput? { get }
}

protocol FavouritesViewModelInput {
    func loadFavourites()
}

protocol FavouritesViewModelOutput: AnyObject {
    func reloadData()
}

class FavouritesViewModel: NSObject, FavouritesViewModelType {
    var input: FavouritesViewModelInput { self }
    
    weak var output: FavouritesViewModelOutput?
    
    var favorites: [FavoriteItem] = []
}

extension FavouritesViewModel: FavouritesViewModelInput{
    func loadFavourites() {
        self.favorites = FavouritesManager.shared.items
        self.output?.reloadData()
    }
}

extension FavouritesViewModel: FavouritesManagerDelegate {
    func favoritesDidUpdate() {
        self.loadFavourites()
    }
}
