//
//  NetworkService.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import Foundation
import Combine

private let networkQueue = DispatchQueue(label: "com.vahid.youtubekids.networkQueue")

struct NetworkFactory {
    func instance<Session: URLSessionProtocol>(session: Session = URLSession.shared) -> some NetworkService { NetworkAgent(session: session) }
    func cacheFirst() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }
}

protocol NetworkService: Sendable {
    @discardableResult func fetch<T: Decodable>(url: URL, perform action: @escaping ((Response<T>) -> Void)) async -> ResponsePublisher<T>
}

private actor NetworkAgent: NetworkService {
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()
    private var cancellables: Set<AnyCancellable> = []
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    @discardableResult func fetch<T: Decodable>(url: URL, perform action: @escaping ((Response<T>) -> Void)) async -> ResponsePublisher<T> {
        let subject = perform(action: action)
        do {
            let (data, _) = try await session.data(from: url, delegate: nil)
            do {
                let response = try decoder.decode(T.self, from: data)
                subject.send(.success(response))
            } catch {
                subject.send(.failure(.decode))
            }
        } catch {
            subject.send(.failure(.network(message: error.localizedDescription)))
        }
        return subject
    }
    
    @discardableResult private func perform<T: Decodable>(action: @escaping ((Response<T>) -> Void)) -> ResponsePublisher<T> {
        let subject: ResponsePublisher<T> = ResponsePublisher<T>()
        subject
            .subscribe(on: networkQueue)
            .receive(on: RunLoop.main)
            .sink(receiveValue: action)
            .store(in: &cancellables)
        return subject
    }
}

enum AppError: Error, Equatable {
    case network(message: String)
    case decode
}

typealias Response<T: Decodable> = Result<T, AppError>
typealias ResponsePublisher<T: Decodable> = PassthroughSubject<Response<T>, Never>

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
