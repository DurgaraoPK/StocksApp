//
//  StockDetailsModel.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//

import Foundation

struct StockDetailsModel: Decodable {
    let symbol: String
    let description: String?
    let marketCap: Double?
    let peRatio: Double?
}
