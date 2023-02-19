//
//  ImageGridView.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import SwiftUI
import Kingfisher

struct ImageGridView: View {
    
    let namespace: Namespace.ID
    
    @Binding var images: [NasaPicture]
    
    @Binding var selectedImageIndex: Int?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(images, id: \.hdurl) { nasaPicture in
                    KFImage(URL(string: nasaPicture.hdurl))
                        .fade(duration: 2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(4)
                        .onTapGesture {
                            withAnimation {
                                selectedImageIndex = images.firstIndex(where: { image in
                                    image.hdurl == nasaPicture.hdurl
                                })
                            }
                        }
                }
            }
        }
    }
}
