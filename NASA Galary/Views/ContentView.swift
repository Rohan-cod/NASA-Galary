//
//  ContentView.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var imagesViewModel: ImagesViewModel = ImagesViewModel()
    
    @Namespace private var namespace
    
    @State var selectedImageIndex: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                if imagesViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ImageGridView(namespace: namespace, images: $imagesViewModel.images, selectedImageIndex: $selectedImageIndex)
                        .padding(.horizontal, 3)
                        .transition(.opacity)
                        .opacity(selectedImageIndex == nil ? 1 : 0)
                    
                    if selectedImageIndex != nil {
                        ImageDetailView(images: $imagesViewModel.images, selectedImageIndex: $selectedImageIndex, namespace: namespace)
                            .gesture(
                                DragGesture(minimumDistance: 50)
                                    .onChanged {
                                        if $0.startLocation.x > $0.location.x {
                                            if let index = selectedImageIndex, index > 0 {
                                                withAnimation {
                                                    selectedImageIndex = index - 1
                                                }
                                            }
                                        } else if $0.startLocation.x > $0.location.x {
                                            if let index = selectedImageIndex, index < imagesViewModel.images.count - 1 {
                                                withAnimation {
                                                    selectedImageIndex = index + 1
                                                }
                                            }
                                        }
                                    }
                            )
                    }
                }
            }
            .onAppear {
                imagesViewModel.fetchImagesFromURL()
            }
            .alert("Couldn't Load Images!", isPresented: self.$imagesViewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle(Text(selectedImageIndex == nil ? "Nasa Galary" : imagesViewModel.images[selectedImageIndex!].title))
            .navigationBarTitleDisplayMode(selectedImageIndex == nil ? .automatic : .inline)
        }
        
    }
}
