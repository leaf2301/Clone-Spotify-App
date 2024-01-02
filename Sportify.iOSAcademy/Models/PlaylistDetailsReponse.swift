//
//  PlaylistDetailsReponse.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 01/01/2024.
//

import Foundation

struct PlaylistDetailsReponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}
struct PlaylistItem: Codable {
    let track: AudioTrack
}
