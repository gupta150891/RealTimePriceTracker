//
//  Stocks.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import Foundation

struct Stock: Identifiable, Codable, Hashable {
    let id = UUID()
    let symbol: String
    var price: Double
    var previousPrice: Double

    var isPriceUp: Bool {
        price > previousPrice
    }
}
