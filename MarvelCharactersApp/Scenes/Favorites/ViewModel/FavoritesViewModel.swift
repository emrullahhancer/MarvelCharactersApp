//
//  FavoritesViewModel.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 15.08.2021.
//

import Foundation

class FavoritesViewModel {
    
    var favorites = [CharacterListResultModel]()
    
    func getFavorites() {
        if let data = UserDefaults.standard.object(forKey: "FavoriteCharacters") as? Data, let favorites = try? JSONDecoder().decode([CharacterListResultModel].self, from: data) {
                self.favorites = favorites
             }
        }
    
}
