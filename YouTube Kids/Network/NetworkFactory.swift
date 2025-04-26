//
//  NetworkFactory.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/26/25.
//

import Foundation

struct NetworkFactory {
    func cacheFirst() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }
}
