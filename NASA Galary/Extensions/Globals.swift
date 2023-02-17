//
//  Globals.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import Foundation

public class Globals {
    static let shared = Globals()

    var formatter = DateFormatter()
    
    init() {
        formatter.dateFormat = "yyyy-MM-dd"
    }
}
