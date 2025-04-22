//
//  Constants.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Foundation

struct Constants {
    static let errors: [Int: NSError] = [
        403: Constants.Error(message: "The requested item was not found.", code: 403).nsError,
    ]
    
    static let JSON_johnAsPerson: String = """
    {
        "name": "John",
        "age": 25
    }
    """
        
    final class Error {
        let message: String
        let code: Int
        
        init(message: String, code: Int) {
            self.message = message
            self.code = code
        }
        
        lazy var nsError: NSError = {
            return NSError(domain: "ERROR_CODE_\(code)", code: code, userInfo: [NSLocalizedDescriptionKey: message])
        }()
    }
}

struct Person: Decodable, Equatable {
    let name: String
    let age: Int
}
