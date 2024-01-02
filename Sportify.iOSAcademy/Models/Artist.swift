//
//  Artist.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 25/12/2023.
//

import Foundation
struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
