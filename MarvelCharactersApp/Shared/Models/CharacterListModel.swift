//
//  CharacterListModel.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 12.08.2021.
//

import Foundation

struct CharacterListModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: CharacterListDataModel?
}

struct CharacterListDataModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case results
    }
    
    var offset, limit, total, count: Int?
    var results: [CharacterListResultModel]?
}

struct CharacterListResultModel: Codable {
    var id: Int?
    var name, resultDescription: String?
    var thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail
    }
}

struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
