//
//  CandidatesFetcher.swift
//  4Hire
//
//  Created by Filip Chwastowski on 28/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct ResponseRoot: Decodable {
    var data: Candidate
}

enum FetchingError: Swift.Error, Equatable {
    case unknown
    case invalidURL
    case parsingFailed
    case downloadFailed
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown): fallthrough
        case (.invalidURL, .invalidURL): fallthrough
        case (.parsingFailed, .parsingFailed): fallthrough
        case (.downloadFailed, .downloadFailed):
            return true
        default:
            return false
        }
    }
}

protocol NetworkingManager {
    typealias FetchResult = Result<Candidate, FetchingError>
    func downloadCandidate(completion: @escaping (FetchResult) -> Void)
}

/// Handles fetching `Candidate`s objects from local storage.
class LocalNetworkingManager : NetworkingManager{
    static var sharedManager = LocalNetworkingManager()
    
    /// Downloads candidate's details.
    /// - Parameter completion: Completion containing fetching result.
    func downloadCandidate(completion: @escaping (LocalNetworkingManager.FetchResult) -> Void) {
        guard let url = Bundle(for: type(of: self)).url(forResource: "candidate", withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
        
        requestData(from: url) { (response) in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let responseRoot = try JSONDecoder().decode(ResponseRoot.self, from: data)
                    completion(.success(responseRoot.data))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            }
        }
    }

    /// Requests data from local storage.
    /// - Parameters:
    ///   - url: File's url.
    ///   - completionBlock: Completion containing fetched data.
    func requestData(from url: URL, completionBlock: @escaping (Result<Data, FetchingError>) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completionBlock(.success(data))
        } catch {
            completionBlock(.failure(.downloadFailed))
        }
    }
}
