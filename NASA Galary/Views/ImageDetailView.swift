//
//  ImageDetailView.swift
//  NASA Galary
//
//  Created by Rohan  Gupta on 17/02/23.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    @Environment(\.presentationMode) private var presentationMode

    @Binding var images: [NasaPicture]
    @Binding var selectedImageIndex: Int?
    
    let namespace: Namespace.ID
    
    @State private var isDescriptionExpanded: Bool = false
    @State private var showInfo: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedImageIndex) {
                    ForEach(images, id: \.self) { nasaPicture in
                        VStack {
                            Text("\(nasaPicture.title)")
                                .multilineTextAlignment(.center)
                                .font(Globals.shared.titleFont)
                                .accessibilityElement()
                                .accessibilityLabel("Image Title: \(nasaPicture.title)")
                            
                            KFImage(URL(string: nasaPicture.hdurl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                                .clipped()
                                .cornerRadius(Globals.shared.cornerRadius)
                                .padding(.horizontal)
                                .accessibilityElement()
                                .accessibilityLabel("Detail Image: \(nasaPicture.hdurl)")
                            
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
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .accessibilityElement()
                                        .accessibilityLabel("Explanation Heading")
                                    
                                    Spacer()
                                    
                                    Button {
                                        withAnimation {
                                            showInfo = true
                                        }
                                    } label: {
                                        Image(systemName: "info.circle")
                                    }
                                    .accessibilityElement()
                                    .accessibilityLabel("Info Button")
                                }
                                
                                if isDescriptionExpanded {
                                    ScrollView(showsIndicators: false) {
                                        Text(nasaPicture.explanation)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .accessibilityElement()
                                            .accessibilityLabel("Explanation")
                                    }
                                }
                            }
                            .padding()

                            Spacer()
                        }
                        .tag(images.firstIndex(where: { pic in
                            pic == nasaPicture
                        }))
                        .transition(.opacity)
                        .alert(images[selectedImageIndex ?? 0].title, isPresented: $showInfo, actions: {
                            Button("OK", role: .cancel) { }
                        }, message: { Text(images[selectedImageIndex ?? 0].infoMessage) })
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                    }
                    
                }
            }
        }
    }
}
