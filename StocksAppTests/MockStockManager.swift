//
//  MockStockManager.swift
//  StocksApp
//
//  Created by Durgarao on 25/03/26.
//

import Foundation
@testable import StocksApp

final class MockStockManager: StockManagerProtocol {

    var shouldReturnError = false
    var mockStocks: [StockListModel] = []
    
    func getStocksList() async -> Result<StockResponse, StocksApp.APIError> {
        if shouldReturnError {            
            return .failure(.invalidResponse)
        } else {
            
            let stock1 = StockResponse.MarketItem(symbol: "ES=F",
                                                  shortName: "S&P Futures",
                                                  regularMarketPrice: StockResponse.ValueWrapper(raw: 46782.0),
                                                  regularMarketChangePercent: StockResponse.ValueWrapper(raw: 10.0))
            let stock2 = StockResponse.MarketItem(symbol: "YM=F",
                                                  shortName: "Dow Futures",
                                                  regularMarketPrice: StockResponse.ValueWrapper(raw: 46782.0),
                                                  regularMarketChangePercent: StockResponse.ValueWrapper(raw: 5.0))
            
            let container = StockResponse.MarketSummaryContainer(result: [stock1, stock2])
            return .success(StockResponse(marketSummaryAndSparkResponse: container))
        }
    }
    
    func getStockDetail(symbol: String) async -> Result<StockDetailsModel, APIError> {
        
        return .success(StockDetailsModel(symbol: symbol, description: "Dow Futures", marketCap: 100, peRatio: 10))
    }
    

}
