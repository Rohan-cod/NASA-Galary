//
//  ImageDetailView.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    @Binding var images: [NasaPicture]
    @Binding var selectedImageIndex: Int?
    
    let namespace: Namespace.ID
    
    @State private var isDescriptionExpanded: Bool = false
    @State private var showInfo: Bool = false
    
    var body: some View {
        VStack {
            TabView(selection: $selectedImageIndex) {
                ForEach(images, id: \.hdurl) { nasaPicture in
                    VStack(alignment: .trailing) {
                        KFImage(URL(string: nasaPicture.hdurl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                            .clipped()
                            .cornerRadius(4)
                            .onTapGesture {
                                withAnimation {
                                    selectedImageIndex = nil
                                }
                            }
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: nil) {
                            HStack {
                                Button {
                                    withAnimation {
                                        isDescriptionExpanded.toggle()
                                    }
                                } label: {
                                    if isDescriptionExpanded {
                                        Image(systemName: "chevron.down")
                                    } else {
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .tint(.primary)
                                Text("Explanation")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Button {
                                    withAnimation {
                                        showInfo = true
                                    }
                                } label: {
                                    Image(systemName: "info.circle")
                                }

                            }
                            if isDescriptionExpanded {
                                ScrollView(showsIndicators: false) {
                                    Text(nasaPicture.explanation)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                    .tag(images.firstIndex(where: { pic in
                        pic.hdurl == nasaPicture.hdurl
                    }))
                    .transition(.opacity)
                    .alert(images[selectedImageIndex ?? 0].title, isPresented: $showInfo, actions: {
                        Button("OK", role: .cancel) { }
                    }, message: { Text("Date: \(Globals.shared.formatter.string(from: images[selectedImageIndex ?? 0].date))\nCopyright: \(images[selectedImageIndex ?? 0].copyright ?? "None")") })
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
        .padding()
    }
}
