//
//  StockAPIClient.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

protocol StockAPIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: APIEndPoint) async throws -> T
    func fetchFinHubStocks<T: Decodable>(_ endpoint: FinHubAPIEndPoint) async throws -> T 
}

final class StockAPIClient: StockAPIClientProtocol {

    private let session = URLSession.shared
    private let apiKey =  "83192180-034b-49d8-bda1-1403a15cc0e3"
    

    func fetch<T: Decodable>(_ endpoint: APIEndPoint) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("yh-finance.p.rapidapi.com",
                         forHTTPHeaderField: "X-RapidAPI-Host")
        
        let (data, _) = try await session.data(for: request)
        // 🔥 DEBUG
        if let json = String(data: data, encoding: .utf8) {
            print("API RESPONSE:", json)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchFinHubStocks<T: Decodable>(_ endpoint: FinHubAPIEndPoint) async throws -> T {
            let (data, response) = try await URLSession.shared.data(from: endpoint.url)

            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }

            return try JSONDecoder().decode(T.self, from: data)
        }
}
