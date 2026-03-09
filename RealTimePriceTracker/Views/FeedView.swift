//
//  FeedView.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import SwiftUI

struct FeedView: View {

    @EnvironmentObject var viewModel: StockFeedViewModel

    var body: some View {

        VStack {

            HStack {

                Text(viewModel.isConnected ? "🟢 Connected" : "🔴 Disconnected")

                Spacer()

                Button(viewModel.isRunning ? "Stop" : "Start") {

                    if viewModel.isRunning {
                        viewModel.stopFeed()
                    } else {
                        viewModel.startFeed()
                    }
                }
            }
            .padding()

            List(viewModel.stocks) { stock in

                NavigationLink(value: stock) {

                    StockRowView(stock: stock)
                }
            }
        }
        .navigationTitle("Stocks")
        .navigationDestination(for: Stock.self) { stock in

            StockDetailView(symbol: stock.symbol)
        }
    }
}
