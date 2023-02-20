//
//  NasaPicture.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 20/02/23.
//

import Foundation

struct NasaPicture: Codable, Hashable {
    var copyright: String?
    var date: Date
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
    
    var infoMessage: String {
        if let copyright = copyright {
            return "Date: \(Globals.shared.formatter.string(from: date))\nCopyright: \(copyright)"
        } else {
            return "Date: \(Globals.shared.formatter.string(from: date))"
        }
    }
}
