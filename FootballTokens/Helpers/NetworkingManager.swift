//
//  NetworkingManager.swift
//  FootballTokens
//
//  Created by Michael on 11/19/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingManager: LocalizedError {
        
        case badURLResponse(url: URL)
        case unowned
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[⚠️] Bad response from URL: \(url)"
            case .unowned: return "[⁉️] Unknown error occuerd"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data,Error> {
        
        var request = URLRequest(url: url)
        request.addValue(APIKeyProvider.coinRankingAPIKey, forHTTPHeaderField: "x-access-token")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingManager.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleComplition(completion: Subscribers.Completion<any Publishers.Decode<AnyPublisher<Data, any Error>, [Welcome], JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            break
        case .failure(let error): print(error.localizedDescription)
        }
    }
}


