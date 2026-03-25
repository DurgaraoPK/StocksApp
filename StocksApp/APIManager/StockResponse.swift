//
//  StockResponse.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//


import Foundation

struct StockResponse: Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryContainer

    struct MarketSummaryContainer: Decodable {
        let result: [MarketItem]
    }

    struct MarketItem: Decodable {
        let symbol: String
        let shortName: String?
        let regularMarketPrice: ValueWrapper?
        let regularMarketChangePercent: ValueWrapper?
    }

    struct ValueWrapper: Decodable {
        let raw: Double?
    }

    var stocks: [StockListModel] {
        marketSummaryAndSparkResponse.result.map {
            StockListModel(
                symbol: $0.symbol,
                name: $0.shortName ?? $0.symbol,
                price: $0.regularMarketPrice?.raw ?? 0,
                changePercent: $0.regularMarketChangePercent?.raw ?? 0
            )
        }
    }
}
