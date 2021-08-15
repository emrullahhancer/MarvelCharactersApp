//
//  Utilities.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation

class Utilities {
    class func isFav(item: CharacterListResultModel, remove: Bool = false, completion: @escaping (Bool) -> Void) {
        var isFav = false
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        if let data = defaults.object(forKey: "FavoriteCharacters") as? Data {
            if var favorites = try? decoder.decode([CharacterListResultModel].self, from: data) {
                if let index = favorites.firstIndex(where: { $0.id == item.id }) {
                    isFav = true
                    completion(isFav)
                    if remove {
                        favorites.remove(at: index)
                        if let encoded = try? encoder.encode(favorites) {
                            defaults.set(encoded, forKey: "FavoriteCharacters")
                        }
                    }
                } else {
                    completion(isFav)
                }
            } else {
                completion(isFav)
            }
        } else {
            completion(isFav)
        }
    }
    
    class func appendFav(item: CharacterListResultModel) {
        
        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
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
