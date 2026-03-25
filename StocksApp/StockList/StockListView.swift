//
//  StockListView.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import SwiftUI

struct StockListView: View {

    @StateObject var viewModel: StockListViewModel
    let container: StockListContainer

    var body: some View {
        NavigationView {
            List(viewModel.filteredStocks) { stock in
                NavigationLink(
                    destination: StockDetailView(
                        viewModel: container.makeStockDetailViewModel(
                            symbol: stock.symbol
                        )
                    )
                ) {
                    StockRowView(stock: stock)
                }
            }
            .navigationTitle("Stocks")
            .searchable(text: $viewModel.searchText)
            .task {
                await viewModel.fetchStocks()
            }
        }
    }
}



struct StockRowView: View {

    let stock: StockListModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.name)
                    .font(.headline)

                Text(stock.symbol)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text("$\(stock.price, specifier: "%.2f")")

                Text("\(stock.changePercent, specifier: "%.2f")%")
                    .foregroundColor(
                        stock.changePercent >= 0 ? .green : .red
                    )
            }
        }
    }
}
