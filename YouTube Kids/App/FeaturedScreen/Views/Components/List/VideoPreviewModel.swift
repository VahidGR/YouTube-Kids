//
//  VideoPreviewModel.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Foundation

protocol VideoPreviewModelProtocol: Sendable {
    var length: String { get }
    var headline: String { get }
    var subheadline: String { get }
    var saveIcon: String { get }
    func save() async
    func updateState()
}

@Observable
final class VideoPreviewModel: VideoPreviewModelProtocol {
    let storage: AppStorage<VideoItem>
    let length: String
    let headline: String
    let subheadline: String
    private(set) var saveIcon: String = "plus.circle"
    private let entity: VideoEntity
    
    init(storage: AppStorage<VideoItem>, entity: VideoEntity) {
        let formatter: NumberStyleFormatter = NumberStyleFormatter()
        let stars: String = String(entity.rating).appending(" ⭐️")
        let formattedViews: String = formatter.shortenNumber(entity.views).appending(" views")
        
        self.storage = storage
        self.length = formatter.time(for: entity.duration)
        self.headline = entity.title
        self.subheadline = [entity.channel, stars, formattedViews].joined(separator: " • ")
        self.entity = entity
    }
    
    convenience init(storage: AppStorage<VideoItem>, item: VideoItem) {
        self.init(storage: storage, entity: item.entity)
        self.saveIcon = "checkmark.circle.fill"
    }
    
    func save() async {
        let isSaved = await storage.exists(entity.id)
        if isSaved {
            await storage.remove(entity.id)
        } else {
            await storage.add(VideoItem(entity: entity, date: .now))
        }
        await updateSavedIcon()
    }
    
    private func isSaved() async -> Bool {
        await storage.exists(entity.id)
    }
    
    private func updateSavedIcon() async {
        let isSaved = await storage.exists(entity.id)
        if isSaved {
            saveIcon = "checkmark.circle.fill"
        } else {
            saveIcon = "plus.circle"
        }
    }
    
    func updateState() {
        Task {
            await updateSavedIcon()
        }
    }
}

/*
import SwiftData

@Model
final class VideoPreviewDataModel {
    @Attribute(.unique) var videoId: String
    @Attribute(.spotlight) var title: String
    var channel: String
    var duration: Int
    
    init(videoId: String, title: String, channel: String, duration: Int) {
        self.videoId = videoId
        self.title = title
        self.channel = channel
        self.duration = duration
    }
}
 */
