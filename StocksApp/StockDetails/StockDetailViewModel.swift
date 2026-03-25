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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: StockManagerProtocol
    private let symbol: String
    
    init(repository: StockManagerProtocol, symbol: String) {
        self.repository = repository
        self.symbol = symbol
    }
    
    func fetchDetails() async {
        isLoading = true
        errorMessage = nil
        
        let result = await repository.getStockDetail(symbol: symbol)
        
        switch result {
        case .success(let stockDetails):
            detail = stockDetails
            
        case .failure(let error):
            detail = nil
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
