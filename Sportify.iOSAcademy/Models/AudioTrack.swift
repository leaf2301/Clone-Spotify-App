//
//  AudioTrack.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 25/12/2023.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Double
    let duration_ms: Double
    let explicit: Bool
    let external_urls: [String:String]
    let id: String
    let name: String
}


