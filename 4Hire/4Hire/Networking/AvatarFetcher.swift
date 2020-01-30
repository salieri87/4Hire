//
//  AvatarFetcher.swift
//  4Hire
//
//  Created by Filip Chwastowski on 30/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

enum AvatarFetchingError: Swift.Error {
    case invalidURL
    case downloadFailed
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.downloadFailed, .downloadFailed): fallthrough
        case (.invalidURL, .invalidURL):
            return true
        default:
            return false
        }
    }
}

protocol AvatarDataFetcher {
    typealias FetchResult = Result<Data, AvatarFetchingError>
    func downloadAvatarData(of userName: String, completion: @escaping (FetchResult) -> Void )
}

/// Github dedicated fetcher of user avatar image's data.
struct GithubAvatarFetcher: AvatarDataFetcher {
    
    func downloadAvatarData(of userName: String, completion: @escaping (Self.FetchResult) -> Void) {
        guard let url = URL(string: "http://github.com/\(userName).png") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.downloadFailed))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

