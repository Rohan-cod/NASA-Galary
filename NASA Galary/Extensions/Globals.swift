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
    let smallFont: Font = .system(size: 12, weight: .medium)
    
    init() {
        formatter.dateFormat = "yyyy-MM-dd"
    }
}
