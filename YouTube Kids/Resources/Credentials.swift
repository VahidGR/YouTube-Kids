//
//  Credentials.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Foundation

struct Credentials {
    static let apiKey: String = environment(value: "YT_API_KEY")
    
    private static func environment<T>(value name: String) -> T {
        return unwrap(ProcessInfo.processInfo.environment[name] as? T)
    }
    
    /// Hide initialization method for other objects
    private init() { }
}
