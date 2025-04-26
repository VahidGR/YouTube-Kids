//
//  VideoEntity.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/23/25.
//

import Foundation

struct VideoEntity: Decodable {
    let id: UUID
    let channel: String
    let title: String
    let views: Int
    let duration: Int
    let rating: Double
}
