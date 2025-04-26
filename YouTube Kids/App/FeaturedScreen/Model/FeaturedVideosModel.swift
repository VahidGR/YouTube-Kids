//
//  FeaturedVideosModel.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/26/25.
//

import Foundation

@Observable final class FeaturedVideosModel {
    private let network: NetworkService
    private(set) var categories: [CategoryEntity] = []
    
    init() {
        let factory = NetworkFactory()
        let configuration = factory.cacheFirst()
        let session = URLSession(configuration: configuration)
        network = factory.instance(session: session)
    }
    
    func loadCategories() async {
        // GET https://www.googleapis.com/youtube/v3/videoCategories?part=snippet&regionCode=US&key=YOUR_API_KEY
        let url = URL(string: "https://www.googleapis.com/youtube/v3/videoCategories")!
            .appending(queryItems: [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "regionCode", value: "US"),
            URLQueryItem(name: "key", value: Credentials.apiKey),
        ])
        let _: ResponsePublisher<Categories> = await network.fetch(
            url: url
        ) { [unowned self] result in
            switch result {
            case .success(let value):
                let categories = value.items.map(CategoryEntity.init)
                self.categories = categories
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct Categories: Decodable {
    let kind: String
    let etag: String
    let items: [Item]
    
    struct Item: Decodable {
        let etag: String
        let kind: String
        let id: String
        let snippet: Snippet
        
        struct Snippet: Decodable {
            let title: String
            let assignable: Bool
            let channelId: String
        }
    }
}

struct CategoryEntity {
    let title: String
    let id: String
    
    init(_ data: Categories.Item) {
        self.title = data.snippet.title
        self.id = data.id
    }
}
