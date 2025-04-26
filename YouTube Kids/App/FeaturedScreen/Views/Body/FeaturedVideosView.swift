//
//  FeaturedVideosView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import SwiftUI

struct FeaturedVideosView: View {
    let appStorage: AppStorage<VideoItem>
    @State var model: FeaturedVideosModel = .init()
    let videos: [VideoEntity]
    var body: some View {
        VStack {
            VideoCategoriesSlidingView(categories: model.categories)
                .padding(.top)
            List(videos, id: \.id) { video in
                VideoPreviewView(model: VideoPreviewModel(storage: appStorage, entity: video))
                    .listRowSeparator(.hidden)
                    .padding(.bottom)
            }
            .listStyle(.plain)
            .task {
                await model.loadCategories()
            }
        }
    }
}
