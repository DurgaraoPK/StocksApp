//
//  StockManager.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//


import Foundation

protocol StockManagerProtocol {
    func getStocksList() async throws -> [StockListModel]
    func getStockDetail(symbol: String) async throws -> StockDetailsModel
    
    // Created for FinHub API's
    func fetchStocks() async throws -> [StockListModel]
    func fetchStockDetail(symbol: String) async throws -> StockDetailsModel
}

final class StockManager: StockManagerProtocol {

    private let apiClient: StockAPIClientProtocol
    
    // FinHub API Key
    private let apiKey =  "d71d8chr01qot5jd0060d71d8chr01qot5jd006g"

    init(apiClient: StockAPIClientProtocol) {
        self.apiClient = apiClient
    }

    func getStocksList() async throws -> [StockListModel] {
        let response: StockResponse =
            try await apiClient.fetch(.stockList())
        return response.stocks
    }

    func getStockDetail(symbol: String) async throws -> StockDetailsModel {
        try await apiClient.fetch(.stockDetail(symbol: symbol))
    }
    
    
    func fetchStocks() async throws -> [StockListModel] {

            try await withThrowingTaskGroup(of: StockListModel.self) { group in

                for symbol in ["AAPL", "MLP", "AAPI", "PAPL", "SUNE", "PNPL"] {
                    group.addTask {
                        async let quote: FinnhubQuote =
                            self.apiClient.fetchFinHubStocks(.quote(symbol: symbol, apiKey: self.apiKey))

                        async let profile: FinnhubProfile =
                            self.apiClient.fetchFinHubStocks(
                                FinHubAPIEndPoint(
                                    url: URL(string:
                                        "https://finnhub.io/api/v1/stock/profile2?symbol=\(symbol)&token=\(self.apiKey)"
                                    )!
                                )
                            )

                        let (q, p) = try await (quote, profile)

                        return StockListModel(
                            symbol: symbol,
                            name: p.name ?? symbol,
                            price: q.c,
                            changePercent: q.dp
                        )
                    }
                }

                return try await group.reduce(into: []) { $0.append($1) }
            }
        }

        func fetchStockDetail(symbol: String) async throws -> StockDetailsModel {

            let profile: FinnhubProfile =
                try await apiClient.fetchFinHubStocks(
                    FinHubAPIEndPoint(
                        url: URL(string:
                            "https://finnhub.io/api/v1/stock/profile2?symbol=\(symbol)&token=\(apiKey)"
                        )!
                    )
                )

            let _: FinnhubQuote =
                try await apiClient.fetchFinHubStocks(.quote(symbol: symbol, apiKey: apiKey))

            return StockDetailsModel(
                symbol: symbol,
                description: profile.name,
                marketCap: nil,
                peRatio: nil
            )
        }
}
