//
//  Episode.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation

// MARK: - EpisodeElement
struct Episode: Codable {
    let id: Int
    let name: String?
    let season, number: Int?
    let image: Image?
    let summary: String?
}

struct Season: Codable {
    let number: Int?
    let episodes: [Episode]?
}
