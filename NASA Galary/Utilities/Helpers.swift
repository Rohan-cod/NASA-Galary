//
//  Helpers.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 20/02/23.
//

import Foundation

func parse(jsonData: Data) -> [NasaPicture]? {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Globals.shared.formatter)
        let decodedData = try decoder.decode([NasaPicture].self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}
