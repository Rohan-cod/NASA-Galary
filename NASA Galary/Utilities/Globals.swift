//
//  Globals.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import Foundation
import SwiftUI

public class Globals {
    static let shared = Globals()

    var formatter = DateFormatter()
    let titleFont: Font = .system(size: 24, weight: .bold)
    let cornerRadius: CGFloat = 4
    let fileName: String? = "NasaPictures"
    let jsonURL: URL? = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
    
    private init() {
        formatter.dateFormat = "yyyy-MM-dd"
    }
}
