//
//  NetworkTests.swift
//  YouTube KidsTests
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Testing
@testable import YouTube_Kids

private let delay: Int = 40

struct NetworkTests {
    
    private let factory = NetworkFactory()
    private let session: URLSessionProtocol = MockURLSession()

    @Test func success() async throws {
        let expectation: NetworkExpectation = try .expecting(
            json: Constants.JSON_johnAsPerson,
            statusCode: 200
        )
        let sut: NetworkService = factory.instance(session: expectation.session())
        
        await sut.fetch(url: expectation.url) { (result: Response<Person>) in
            switch result {
            case .success(let person):
                #expect(person == Person(name: "John", age: 25))
            case .failure:
                #expect(false)
            }
            print("[TEST]", String(describing: result))
        }
        
        try await Task.sleep(for: .milliseconds(delay))
    }
    
    @Test func networkFailure() async throws {
        let statusCode: Int = 403
        let expectedError = try expectingError(statusCode: statusCode)
        let expectation: NetworkExpectation = try .expecting(
            json: nil,
            statusCode: statusCode
        )
        let sut: NetworkService = factory.instance(session: expectation.session())
        
        await sut.fetch(url: expectation.url) { (result: Response<Person>) in
            switch result {
            case .success:
                #expect(false)
            case .failure(let error):
                #expect(error == AppError.network(message: expectedError.localizedDescription))
            }
            print("[TEST]", String(describing: result))
        }
        
        try await Task.sleep(for: .milliseconds(delay))
    }
    
    @Test func decodingFailure() async throws {
        let expectation: NetworkExpectation = try .expecting(
            json: Constants.JSON_johnAsPerson,
            statusCode: 200
        )
        let sut: NetworkService = factory.instance(session: expectation.session())
        
        await sut.fetch(url: expectation.url) { (result: Response<Bool>) in
            switch result {
            case .success:
                #expect(false)
            case .failure(let error):
                #expect(error == AppError.decode)
            }
            print("[TEST]", String(describing: result))
        }
        
        try await Task.sleep(for: .milliseconds(delay))
    }
}
