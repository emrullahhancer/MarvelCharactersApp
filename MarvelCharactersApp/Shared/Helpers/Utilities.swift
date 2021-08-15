//
//  Utilities.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation

class Utilities {
    
    static let encoder = JSONEncoder()
    static let defaults = UserDefaults.standard
    static let decoder = JSONDecoder()
    
    class func isFav(item: CharacterListResultModel, remove: Bool = false) -> Bool {
        var isFav = false
        
        if let data = defaults.object(forKey: "FavoriteCharacters") as? Data {
            if var favorites = try? decoder.decode([CharacterListResultModel].self, from: data) {
                if let index = favorites.firstIndex(where: { $0.id == item.id }) {
                    isFav = true
                    if remove {
                        favorites.remove(at: index)
                        if let encoded = try? encoder.encode(favorites) {
                            defaults.set(encoded, forKey: "FavoriteCharacters")
                        }
                    }
                }
            }
        }
        
        return isFav
    }
    
    class func appendFav(item: CharacterListResultModel) {
        
        if let data = defaults.object(forKey: "FavoriteCharacters") as? Data {
            if var favorites = try? decoder.decode([CharacterListResultModel].self, from: data) {
                favorites.append(item)
                if let encoded = try? encoder.encode(favorites) {
                    defaults.set(encoded, forKey: "FavoriteCharacters")
                }
            }
        } else {
            var favorites = [CharacterListResultModel]()
            favorites.append(item)
            if let encoded = try? encoder.encode(favorites) {
                defaults.set(encoded, forKey: "FavoriteCharacters")
            }
        }
        
    }
    
    
}
