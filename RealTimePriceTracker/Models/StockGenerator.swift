//
//  StockGenerator.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import Foundation

struct StockGenerator {

    static let symbols = [
        "AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","META","NFLX",
        "INTC","AMD","ORCL","IBM","ADBE","CRM","SHOP","UBER",
        "LYFT","BABA","SONY","DIS","PYPL","SQ","TWTR","SPOT","SNAP"
    ]

    static func generateInitialStocks() -> [Stock] {

        symbols.map {
            Stock(symbol: $0,
                  price: Double.random(in: 100...500),
                  previousPrice: 0)
        }
    }

    static func randomPrice(from price: Double) -> Double {
        price + Double.random(in: -5...5)
    }
}
