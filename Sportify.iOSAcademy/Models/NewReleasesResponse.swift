//
//  NewReleasesResponse.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Double
    let artists: [Artist]
}
