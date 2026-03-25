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
        VStack {
            content
        }
        .padding()
        .navigationTitle("Details")
        .task {
            await viewModel.fetchDetails()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        
        //  LOADING
        if viewModel.isLoading {
            VStack {
                ProgressView()
                Text("Fetching details...")
                    .foregroundColor(.gray)
            }
        }
        
        //  ERROR
        else if let error = viewModel.errorMessage {
            VStack(spacing: 12) {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Button("Retry") {
                    Task {
                        await viewModel.fetchDetails()
                    }
                }
            }
        }
        
        //  DATA
        else if let detail = viewModel.detail {
            VStack(alignment: .leading, spacing: 12) {
                
                Text(detail.symbol)
                    .font(.largeTitle)
                
                if let desc = detail.description {
                    Text(desc)
                }
                
                Text("Market Cap: \(detail.marketCap ?? 0)")
                Text("PE Ratio: \(detail.peRatio ?? 0)")
            }
        }
        
        //  FALLBACK
        else {
            Text("No data available")
                .foregroundColor(.gray)
        }
    }
}
