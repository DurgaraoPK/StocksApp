//
//  StockManagerMock.swift
//  StocksApp
//
//  Created by Durgarao on 25/03/26.
//

import Testing
@testable import StocksApp

final class StockManagerMock: StockManagerProtocol {
    func fetchStockDetail(symbol: String) async throws -> StocksApp.StockDetailsModel {
        StockDetailsModel(symbol: "Apple", description: "Apple", marketCap: 10, peRatio: 5)
    }
    
    func getStocksList() async throws -> [StocksApp.StockListModel] {
        return []
    }
    
    func getStockDetail(symbol: String) async throws -> StocksApp.StockDetailsModel {
        return StockDetailsModel(symbol: "Apple", description: "Apple", marketCap: 10, peRatio: 5)
    }
    

    func fetchStocks() async throws -> [StockListModel] {
        [
            StockListModel(symbol: "AAPL",
                  name: "Apple",
                  price: 150,
                  changePercent: 1.2)
        ]
    }
}
