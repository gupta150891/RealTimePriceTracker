//
//  StockView.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import SwiftUI

struct StockRowView: View {

    let stock: Stock

    var body: some View {

        HStack {

            Text(stock.symbol)
                .font(.headline)

            Spacer()

            Text(String(format: "%.2f", stock.price))

            Image(systemName: stock.isPriceUp ? "arrow.up" : "arrow.down")
                .foregroundColor(stock.isPriceUp ? .green : .red)
        }
    }
}
