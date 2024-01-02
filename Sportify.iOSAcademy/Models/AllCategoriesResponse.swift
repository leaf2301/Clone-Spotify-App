//
//  AllCategoriesResponse.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 02/01/2024.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}


