//
//  StockListContainer.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

@MainActor
final class StockListContainer {

    // MARK: - Core
    private lazy var apiClient: StockAPIClientProtocol = StockAPIClient()
    private lazy var repository: StockManagerProtocol =
    StockManager(apiClient: apiClient)

    // MARK: - ViewModels
    func makeStockListViewModel() -> StockListViewModel {
        StockListViewModel(repository: repository)
    }

    func makeStockDetailViewModel(symbol: String) -> StockDetailViewModel {
        StockDetailViewModel(repository: repository, symbol: symbol)
    }
}
