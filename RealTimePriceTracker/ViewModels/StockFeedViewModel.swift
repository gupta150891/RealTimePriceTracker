//
//  StockFeedViewModel.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import Foundation
import Combine

class StockFeedViewModel: ObservableObject {

    @Published var stocks: [Stock] = []
    @Published var isConnected = false
    @Published var isRunning = false

    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    init() {

        stocks = StockGenerator.generateInitialStocks()

        WebSocketService.shared.publisher
            .sink { [weak self] message in
                DispatchQueue.main.async {
                    self?.handleMessage(message)
                }
            }
            .store(in: &cancellables)
    }

    func startFeed() {

        WebSocketService.shared.connect()
        isConnected = true
        isRunning = true

        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.sendRandomPrices()
            }
    }

    func stopFeed() {

        WebSocketService.shared.disconnect()
        timer?.cancel()

        isConnected = false
        isRunning = false
    }

    private func sendRandomPrices() {

        for stock in stocks {

            let newPrice = StockGenerator.randomPrice(from: stock.price)

            let message = "\(stock.symbol):\(newPrice)"

            WebSocketService.shared.send(message: message)
        }
    }

    private func handleMessage(_ message: String) {

        let parts = message.split(separator: ":")

        guard parts.count == 2 else { return }

        let symbol = String(parts[0])
        let price = Double(parts[1]) ?? 0

        guard let index = stocks.firstIndex(where: {$0.symbol == symbol}) else { return }

        stocks[index].previousPrice = stocks[index].price
        stocks[index].price = price

        stocks.sort { $0.price > $1.price }
    }
}
