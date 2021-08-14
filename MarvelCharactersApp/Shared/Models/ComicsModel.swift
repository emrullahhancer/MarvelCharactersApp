//
//  ComicsModel.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation

struct ComicsModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: ComicsData?
}

// MARK: - DataClass
struct ComicsData: Codable {
    var offset, limit, total, count: Int?
    var results: [ComicsResult]?
}

// MARK: - Result
struct ComicsResult: Codable {
    var id, digitalID: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription, resultDescription: String?
    var modified: String?
    var isbn, upc, diamondCode, ean: String?
    var issn, format: String?
    var pageCount: Int?
    var textObjects: [TextObject]?
    var resourceURI: String?
    var urls: [URLElement]?
    var series: Series?
    var dates: [DateElement]?
    var prices: [Price]?
    var thumbnail: Thumbnail?
    var images: [Thumbnail]?
    var creators: Creators?
    var characters: Characters?
    var stories: Stories?
    var events: Characters?

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Series]?
    var returned: Int?
}

// MARK: - Series
struct Series: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - Creators
struct Creators: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [CreatorsItem]?
    var returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    var resourceURI: String?
    var name, role: String?
}

// MARK: - DateElement
struct DateElement: Codable {
    var type: String?
    var date: String?
}

// MARK: - Price
struct Price: Codable {
    var type: String?
    var price: Double?
}

// MARK: - Stories
struct Stories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [StoriesItem]?
    var returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    var resourceURI: String?
    var name, type: String?
}

// MARK: - TextObject
struct TextObject: Codable {
    var type, language, text: String?
}

// MARK: - URLElement
struct URLElement: Codable {
    var type: String?
    var url: String?
}

// MARK: - Encode/decode helpers
