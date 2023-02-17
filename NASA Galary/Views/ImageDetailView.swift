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
    
    var body: some View {
        VStack {
            TabView(selection: $selectedImageIndex) {
                ForEach(images, id: \.hdurl) { nasaPicture in
                    VStack(alignment: .trailing) {
                        VStack(spacing: 1) {
                            HStack {
                                Spacer()
                                Text("Date: \(Globals.shared.formatter.string(from: nasaPicture.date))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                            }
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
                            if let copyright = nasaPicture.copyright {
                                HStack {
                                    Spacer()
                                    Text("Copyright: \(copyright)")
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                }
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
                                .padding(.top, 6)
                                .tint(.primary)
                                Text("Explanation")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top, 8)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            if isDescriptionExpanded {
                                ScrollView(showsIndicators: false) {
                                    Text(nasaPicture.explanation)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .padding(.top, 8)
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
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
        .padding()
    }
}
