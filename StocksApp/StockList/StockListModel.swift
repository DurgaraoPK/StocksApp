//
//  StockListModel.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

struct StockListModel: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let changePercent: Double
}
