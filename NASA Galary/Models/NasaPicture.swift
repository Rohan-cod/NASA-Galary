//
//  NasaPicture.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import Foundation

struct NasaPicture: Codable {
    var copyright: String?
    var date: Date
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}
