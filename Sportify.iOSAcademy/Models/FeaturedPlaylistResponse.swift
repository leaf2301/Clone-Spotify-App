//
//  FeaturedPlaylistResponse.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}

struct CategoryPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}
