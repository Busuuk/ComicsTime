//
//  MangaModel.swift
//  ComicsTime
//
//  Created by Simone Di Blasi on 10/12/24.
//

import Foundation

struct MangaResponse: Codable {
    let code: Int
    let data: Manga
}

struct Manga: Codable {
    let id: String
    let title: String
    let subTitle: String
    let status: String
    let thumb: String
    let summary: String
    let authors: [String]
    let genres: [String]
    let nsfw: Bool
    let type: String
    let totalChapter: Int
    let createAt: TimeInterval
    let updateAt: TimeInterval

    enum CodingKeys: String, CodingKey {
        case id, title, status, thumb, summary, authors, genres, nsfw, type
        case subTitle = "sub_title"
        case totalChapter = "total_chapter"
        case createAt = "create_at"
        case updateAt = "update_at"
    }
}
