//
//  ImagesViewModel.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import Foundation
import SwiftUI

class ImagesViewModel: ObservableObject {
    
    @Published var images: [NasaPicture] = [NasaPicture]()
    @Published var showAlert: Bool = false
    
    private let fileName: String? = "NasaPictures"
    
    func fetchImagesFromURL() {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                if let pictures = parse(jsonData: data) {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.images = pictures.sorted(by: { $0.date > $1.date })
                        }
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.showAlert = true
                }
            }
            print("error: \(error)")
        }
    }
    
    func parse(jsonData: Data) -> [NasaPicture]? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Globals.shared.formatter)
            let decodedData = try decoder.decode([NasaPicture].self, from: jsonData)
            return decodedData
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.showAlert = true
                }
            }
            print("error: \(error)")
        }
        return nil
    }
}
