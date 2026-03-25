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
        do {
            
          //stocks = try await repository.getStocksList()
            
            //Since the Rapid API's are not working temporarly calling the FinHub API's
            stocks = try await repository.fetchStocks()
        } catch {
            print("Error:", error)
        }
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
