//
//  MockURLSession.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Foundation
@testable import YouTube_Kids

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        if let data, let response {
            return (data, response)
        }
        fatalError()
    }
}
