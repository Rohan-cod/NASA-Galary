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
    @Published var isLoading: Bool = false
    
    private let fileName: String? = "NasaPictures"
    
    private let jsonURL: URL? = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
    
    func fetchImagesFromURL() {
        withAnimation {
            isLoading = true
        }
        if let url = jsonURL {
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
              if let data = data {
                  guard let self = self else { withAnimation { self?.isLoading = false }; return }
                  if let pictures = self.parse(jsonData: data) {
                      DispatchQueue.main.async {
                          withAnimation {
                              self.images = pictures.sorted(by: { $0.date > $1.date })
                              self.isLoading = false
                          }
                      }
                  } else {
                      withAnimation {
                          self.isLoading = false
                      }
                  }
               }
           }.resume()
        } else {
            withAnimation {
                isLoading = false
            }
        }
    }
    
    func fetchImagesFromFile() {
        withAnimation {
            isLoading = true
        }
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                if let pictures = parse(jsonData: data) {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.images = pictures.sorted(by: { $0.date > $1.date })
                            self.isLoading = false
                        }
                    }
                } else {
                    withAnimation {
                        isLoading = false
                    }
                }
            } else {
                withAnimation {
                    isLoading = false
                }
            }
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.showAlert = true
                }
            }
            print("error: \(error)")
            withAnimation {
                isLoading = false
            }
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
