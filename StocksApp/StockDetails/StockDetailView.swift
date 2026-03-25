//
//  StockDetailView.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import SwiftUI

struct StockDetailView: View {

    @StateObject var viewModel: StockDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            if let detail = viewModel.detail {
                Text(detail.symbol)
                    .font(.largeTitle)

                if let desc = detail.description {
                    Text(desc)
                }

                Text("Market Cap: \(detail.marketCap ?? 0)")
                Text("PE Ratio: \(detail.peRatio ?? 0)")
            } else {
                ProgressView()
            }
        }
        .padding()
        .navigationTitle("Details")
        .task {
            await viewModel.fetchDetails()
        }
    }
}
