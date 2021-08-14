//
//  APIService.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 12.08.2021.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    let ts = Int64(Date().timeIntervalSince1970 * 1000)
    let privateKey = "9c79c30491fdacef35afb1abe0f20ef659975f3d"
    let publicKey = "b4310cb9d9c9c8ce019c8dde163b1ca9"
    
    func getCharacters(offset: Int = 0, completion: @escaping (CharacterListModel) -> Void, failure: @escaping (Error) -> Void) {
        
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        let params = [
            "limit" : 30,
            "offset" : offset,
            "hash" : hash,
            "apikey" : publicKey,
            "ts" : ts
        ] as [String : Any]
        
        ServiceConnector.shared.connect(.Home(Params: params)) { target, response in
            if let jsonData = response.data(using: .utf8) {
                if let responseConvert = try? JSONDecoder().decode(CharacterListModel.self, from: jsonData) {
                    completion(responseConvert)
                } else {
                    failure(.ParseFailed)
                }
            }
        } error: { target, err in
            failure(.Failure)
        }
        
    }
    
    func getComics(characterID: String, completion: @escaping (ComicsModel) -> Void, failure: @escaping (Error) -> Void) {
        
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        let params = [
            "limit" : 10,
            "formatType" : "comic",
            "dateRange" : "2005-01-01,2021-12-31",
            "orderBy" : "-focDate",
            "hash" : hash,
            "apikey" : publicKey,
            "ts" : ts
        ] as [String : Any]
        
        ServiceConnector.shared.connect(.Comics(Params: params, CharacterID: characterID)) { target, response in
            if let jsonData = response.data(using: .utf8) {
                if let responseConvert = try? JSONDecoder().decode(ComicsModel.self, from: jsonData) {
                    completion(responseConvert)
                } else {
                    failure(.ParseFailed)
                }
            }
        } error: { target, err in
            failure(.Failure)
        }
        
    }
}
