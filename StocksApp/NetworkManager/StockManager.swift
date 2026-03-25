//
//  StockManager.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//


import Foundation

protocol StockManagerProtocol {
    func getStocksList() async -> Result<StockResponse, APIError>
    func getStockDetail(symbol: String) async  -> Result<StockDetailsModel, APIError>
}

final class StockManager: StockManagerProtocol {
    
    private let apiClient: StockAPIClientProtocol
    
    init(apiClient: StockAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    // MARK: - Stock List
    func getStocksList() async -> Result<StockResponse, APIError> {
        
        let result: Result<StockResponse, APIError> =
        await apiClient.fetch(.stockList())
        
        return result
    }
    
    // MARK: - Stock Detail
    func getStockDetail(symbol: String) async -> Result<StockDetailsModel, APIError> {
        
        let result: Result<StockDetailsModel, APIError> =
        await apiClient.fetch(.stockDetail(symbol: symbol))
        
        return result
    }
}
