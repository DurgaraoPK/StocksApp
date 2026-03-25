//
//  APIEndPoint.swift
//  StocksApp
//
//  Created by Durgarao on 24/03/26.
//


import Foundation

struct APIEndPoint {
    let path: String
    let queryItems: [URLQueryItem]

    var url: URL {
        var components = URLComponents(string: "https://yh-finance.p.rapidapi.com")!
        components.path = path
        components.queryItems = queryItems
        return components.url!
    }
}

extension APIEndPoint {

    static func stockList() -> APIEndPoint {
        APIEndPoint(
            path: "/market/v2/get-summary",
            queryItems: [
                URLQueryItem(name: "region", value: "US")
            ]
        )
    }

    static func stockDetail(symbol: String) -> APIEndPoint {
        APIEndPoint(
            path: "/stock/v2/get-summary",
            queryItems: [
                URLQueryItem(name: "symbol", value: symbol)
            ]
        )
    }
}
