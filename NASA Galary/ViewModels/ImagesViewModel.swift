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
    public func getNasaPicturesFromURL() {
        Task {
            isLoading = true
            let result = try? await Service.shared.getNASAPicturesFromURL()
            switch result {
            case .success(let pictures):
                self.images = pictures.sorted(by: { $0.date > $1.date })
                isLoading = false
            case .failure(_):
                isLoading = false
                showAlert = true
                break
            case .none:
                isLoading = false
                break
            }
        }
    }
    
    public func getNasaPicturesFromFile() {
        isLoading = true
        let result = Service.shared.getNASAPicturesFromFile()
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
