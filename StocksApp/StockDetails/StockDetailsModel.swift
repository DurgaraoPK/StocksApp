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


struct FinnhubQuote: Decodable {
    let c: Double  // current price
    let dp: Double // change percent
}

struct FinnhubProfile: Decodable {
    let name: String?
}
