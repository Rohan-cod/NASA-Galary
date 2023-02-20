//
//  ContentView.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var imagesViewModel: ImagesViewModel = ImagesViewModel()
    
    @Namespace private var namespace
    
    @State var selectedImageIndex: Int?
    
    @State var imageClicked: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if imagesViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ImageGridView(namespace: namespace, images: $imagesViewModel.images, selectedImageIndex: $selectedImageIndex, imageClicked: $imageClicked)
                        .padding(.horizontal, 3)
                        .transition(.opacity)
                }
            }
            .onAppear {
                imagesViewModel.getNasaPicturesFromFile()
            }
            .alert("Couldn't Load Images!", isPresented: self.$imagesViewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle(Text("Nasa Galary"))
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $imageClicked) {
                ImageDetailView(images: $imagesViewModel.images, selectedImageIndex: $selectedImageIndex, namespace: namespace)
            }
        }
        
    }
}
