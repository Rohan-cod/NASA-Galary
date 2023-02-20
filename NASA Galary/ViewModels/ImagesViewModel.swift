//
//  ImagesViewModel.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import Foundation

class ImagesViewModel: ObservableObject {
    
    @Published var images: [NasaPicture] = [NasaPicture]()
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    @MainActor
    public func getNasaPicturesFromURL(_ url: String? = nil) {
        Task {
            isLoading = true
            let result = try? await Service.shared.getNASAPicturesFromURL(url)
            switch result {
            case .success(let pictures):
                self.images = pictures.sorted(by: { $0.date > $1.date })
                isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                getNasaPicturesFromFile()
                break
            case .none:
                getNasaPicturesFromFile()
                break
            }
        }
    }
    
    public func getNasaPicturesFromFile(_ fileName: String? = nil, bundle: Bundle = .main) {
        isLoading = true
        let result = Service.shared.getNASAPicturesFromFile(fileName, bundle: bundle)
        switch result {
        case .success(let pictures):
            self.images = pictures.sorted(by: { $0.date > $1.date })
            isLoading = false
        case .failure(_):
            isLoading = false
            showAlert = true
            break
        }
    }
}
