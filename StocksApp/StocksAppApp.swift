//
//  StocksAppApp.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import SwiftUI

@main
struct StocksAppApp: App {
    
    private let container = StockListContainer()
    
    var body: some Scene {
        WindowGroup {
            StockListView(
                viewModel: container.makeStockListViewModel(),
                container: container
            )
        }
    }
}
