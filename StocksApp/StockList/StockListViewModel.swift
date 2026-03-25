//
//  StockListViewModel.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

@MainActor
final class StockListViewModel: ObservableObject {

    @Published var stocks: [StockListModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: StockManagerProtocol
    private var task: Task<Void, Never>?

    init(repository: StockManagerProtocol) {
        self.repository = repository
        //startAutoRefresh()
    }

    var filteredStocks: [StockListModel] {
        guard !searchText.isEmpty else { return stocks }
        return stocks.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }

    func fetchStocks() async {
        isLoading = true
        errorMessage = nil
        
        let result =  await repository.getStocksList()
        
        switch result {
        case .success(let stockResponse):
            if stockResponse.stocks.isEmpty{
                errorMessage = "No stock data available"
                stocks = []
            } else {
                stocks = stockResponse.stocks
            }
        case .failure(_):
            errorMessage = "Failed to fetch stocks. Please try again."
            stocks = []
        }
        
        isLoading = false
    }

    private func startAutoRefresh() {
        task = Task {
            while !Task.isCancelled {
                await fetchStocks()
                try? await Task.sleep(nanoseconds: 8_000_000_000)
            }
        }
    }

    deinit {
        task?.cancel()
    }
}
