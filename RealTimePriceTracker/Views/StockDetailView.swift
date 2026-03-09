//
//  StockDetailView.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import SwiftUI

struct StockDetailView: View {

    let symbol: String

    @EnvironmentObject var viewModel: StockFeedViewModel

    var body: some View {

        if let stock = viewModel.stocks.first(where: {$0.symbol == symbol}) {

            VStack(spacing: 20) {

                Text(symbol)
                    .font(.largeTitle)

                Text(String(format: "%.2f", stock.price))
                    .font(.title)

                Image(systemName: stock.isPriceUp ? "arrow.up" : "arrow.down")
                    .foregroundColor(stock.isPriceUp ? .green : .red)

                Text("This is \(symbol) stock price information.")
                    .padding()
            }
        }
    }
}
