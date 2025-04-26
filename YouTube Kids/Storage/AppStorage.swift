//
//  AppStorage.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/23/25.
//

import Foundation

protocol Storage: Sendable {
    
}
@Observable
final class AppStorage<T: StorageItem>: Storage {
    private(set) var storage: [T] = []
    
    func add(_ item: T) async {
        storage.insert(item, at: 0)
    }
    
    func remove(_ item: T) async {
        storage.removeAll { $0 == item }
    }
    
    func remove(_ id: T.ID) async {
        storage.removeAll { $0.id == id }
    }
    
    func exists(_ id: T.ID) async -> Bool {
        storage.contains(where: { $0.id == id })
    }
    
    func item(for id: T.ID) async -> T {
        unwrap(storage.first { $0.id == id })
    }
}

protocol StorageItem: Sendable, Comparable, Equatable {
    associatedtype ID: Equatable
    var id: ID { get }
}

final class VideoItem: StorageItem {
    typealias ID = UUID
    var id: ID {
        entity.id
    }
    let entity: VideoEntity
    let date: Date
    
    init(entity: VideoEntity, date: Date = Date()) {
        self.entity = entity
        self.date = date
    }
    
    static func > (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.date > rhs.date
    }
    
    static func == (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.date < rhs.date
    }
    
    static func <= (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.date <= rhs.date
    }
    
    static func >= (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.date >= rhs.date
    }
}
