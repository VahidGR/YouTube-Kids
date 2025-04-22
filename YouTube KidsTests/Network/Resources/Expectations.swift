//
//  Expectations.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Testing
import Foundation
@testable import YouTube_Kids

func expectingError(statusCode: Int) throws -> NSError {
    try #require(Constants.errors[statusCode])
}

struct NetworkExpectation {
    let url: URL, data: Data?, response: HTTPURLResponse?, error: Error?
    
    private init(url: URL, data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.url = url
        self.data = data
        self.response = response
        self.error = error
    }
    
    func session() -> URLSessionProtocol {
        let urlSession = MockURLSession()
        urlSession.data = data
        urlSession.response = response
        urlSession.error = error
        
        return urlSession
    }
    
    static func expecting(
        json: String?,
        statusCode: Int?
    ) throws -> Self {
        let data = json?.data(using: .utf8)
        let url = try #require(URL(string: "https://example.com/api/v1/" + UUID().uuidString))
        let response: HTTPURLResponse? = {
            if let statusCode {
                return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            }
            return nil
        }()
        
        let error: Error?
        if let statusCode, statusCode >= 400 {
            error = try expectingError(statusCode: statusCode)
        } else { error = nil }
        
        return NetworkExpectation(url: url, data: data, response: response, error: error)
    }
}
