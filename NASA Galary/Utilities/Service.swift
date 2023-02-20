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
    
    private var fileName: String = Globals.shared.fileName
    private var jsonURL: String = Globals.shared.jsonURL
    
    private init() {}
    
    func getNASAPicturesFromURL(_ jsonURL: String? = nil) async throws -> Result<[NasaPicture], Error> {
        if let url = jsonURL {
            self.jsonURL = url
        }
        
        guard let url = URL(string: self.jsonURL) else {
            return .failure(NASAPictureError.invalidURL)
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

        guard let pictures = parse(jsonData: data) else {
            return .failure(NASAPictureError.noImages)
        }
        
        return .success(pictures)
    }
    
    func getNASAPicturesFromFile(_ fileName: String? = nil, bundle: Bundle = .main) -> Result<[NasaPicture], Error> {
        do {
            if let fileName = fileName {
                self.fileName = fileName
            }
            guard let filePath = bundle.path(forResource: self.fileName, ofType: "json") else {
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
