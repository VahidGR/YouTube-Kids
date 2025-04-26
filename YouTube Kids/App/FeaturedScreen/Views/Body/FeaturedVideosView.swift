//
//  FeaturedVideosView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import SwiftUI

struct FeaturedVideosView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var model: FeaturedVideosModel
    @State var presentAlert: Bool = false
    let videos: [VideoEntity]
    
    var body: some View {
        VStack {
            VideoCategoriesSlidingView(categories: model.categories)
                .padding(.top)
            CollectionView(content: videos) { video in
                VideoPreviewView(model: VideoPreviewModel(storage: model.appStorage, entity: video))
                    .listRowSeparator(.hidden)
                    .padding(.bottom)
            }
            .listStyle(.plain)
            .task {
                await model.loadCategories()
            }
            .onChange(of: model.error) { _, newValue in
                presentAlert = newValue != nil
            }
            .alert(isPresented: $presentAlert, error: model.error, actions: {
                Button(action: { presentAlert = false }, label: { Text("OK") })
            })
        }
    }
}

