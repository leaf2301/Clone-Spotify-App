//
//  SettingsModels.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: ()->Void
}
