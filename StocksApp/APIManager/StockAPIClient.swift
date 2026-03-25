//
//  StockAPIClient.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case decodingFailed
    case network(Error)
    case emptyData

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed:
            return "Failed to parse data"
        case .network(let error):
            return error.localizedDescription
        case .emptyData:
            return "No data available"
        }
    }
}


protocol StockAPIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: APIEndPoint) async -> Result<T, APIError>
}

final class StockAPIClient: StockAPIClientProtocol {

    private let session = URLSession.shared
    private let apiKey =  "1d25241467msh2694ff998033dd8p150678jsn62e5efd82e07"
    

    func fetch<T: Decodable>(_ endpoint: APIEndPoint) async -> Result<T, APIError> {
        do {
            var request = URLRequest(url: endpoint.url)
            request.httpMethod = "GET"
            
            request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            request.addValue("yh-finance.p.rapidapi.com",
                             forHTTPHeaderField: "X-RapidAPI-Host")
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                return .failure(.invalidResponse)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(.decodingFailed)
            }
            
        } catch {
            return .failure(.network(error))
        }
    }
}
