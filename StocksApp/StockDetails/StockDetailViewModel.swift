//
//  StockDetailViewModel.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

@MainActor
final class StockDetailViewModel: ObservableObject {

    @Published var detail: StockDetailsModel?

    private let repository: StockManagerProtocol
    private let symbol: String

    init(repository: StockManagerProtocol, symbol: String) {
        self.repository = repository
        self.symbol = symbol
    }

    func fetchDetails() async {
        do {
            
            //detail = try await repository.getStockDetail(symbol: symbol)
            
            //Since the Rapid API's are not working temporarly calling the FinHub API's
            
            detail = try await repository.fetchStockDetail(symbol: symbol)
        } catch {
            print(error)
        }
    }
}
