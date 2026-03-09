//
//  RealTimePriceTrackerApp.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import SwiftUI

@main
struct RealTimePriceTrackerApp: App {

    @StateObject var viewModel = StockFeedViewModel()

    var body: some Scene {

        WindowGroup {

            NavigationStack {
                FeedView()
            }
            .environmentObject(viewModel)
        }
    }
}
