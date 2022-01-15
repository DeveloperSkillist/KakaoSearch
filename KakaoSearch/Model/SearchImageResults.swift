//
//  SearchImageResults.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation

struct SearchImageResults: Codable {
    let imageResults: [SearchImageResult]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case imageResults = "documents"
        case meta
    }
}

struct SearchImageResult: Codable {
    let collection: String
    let datetime: String
    let displaySitename: String?
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
