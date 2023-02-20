//
//  Service.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 20/02/23.
//

import Foundation

enum NASAPictureError: Error {
    case invalidFilePath
    case invalidURL
    case noImages
}

public class Service {
    static let shared = Service()
    
    private let fileName: String? = Globals.shared.fileName
    private let jsonURL: URL? = Globals.shared.jsonURL
    
    private init() {}
    
    func getNASAPicturesFromURL() async throws -> Result<[NasaPicture], Error> {
        guard let url = jsonURL else {
            return .failure(NASAPictureError.invalidURL)
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

        guard let pictures = parse(jsonData: data) else {
            return .failure(NASAPictureError.noImages)
        }
        
        return .success(pictures)
    }
    
    func getNASAPicturesFromFile() -> Result<[NasaPicture], Error> {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                return .failure(NASAPictureError.invalidFilePath)
            }
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            guard let pictures = parse(jsonData: data) else {
                return .failure(NASAPictureError.noImages)
            }
            return .success(pictures)
        } catch {
            print("error: \(error)")
            return .failure(NASAPictureError.noImages)
        }
    }
}
