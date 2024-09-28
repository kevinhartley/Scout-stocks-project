//
//  Scout_Stocks_ProjectApp.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

@main
struct Scout_Stocks_ProjectApp: App {
    
    @ObservedObject var viewModel = StocksListViewModel(with: StocksDataProvider(endpoint: StocksAPI()))
    
    var body: some Scene {
        WindowGroup {
            StocksListView(viewModel: viewModel)
        }
    }
}
