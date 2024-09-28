//
//  StockDetailsViewModel.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

@MainActor
class StockDetailsViewModel: ObservableObject {
    
    @Published var stockDetails: TickerDetails?
    @Published var aggregateDetails: Aggregate?
    @Published var isLoading: Bool = false
    @Published var error: StocksError?
    
    private var stocksDataProvider: StocksDataProvidable
    
    init(with stocksDataProvider: StocksDataProvidable, tickerAggregate: Aggregate) {
        self.stocksDataProvider = stocksDataProvider
        self.aggregateDetails = tickerAggregate
    }
    
    func getstock(with tickerName: String) {
        isLoading = true
        Task {
            do {
                let stock = try await stocksDataProvider.getStockDetails(with: tickerName)
                self.stockDetails = stock
                isLoading = false
            } catch {
                guard let stocksError = error as? StocksError else {
                    print("UnknownError: \(error)")
                    return
                }
                self.error = stocksError
                isLoading = false
                print("Underlying Issue: \(stocksError)")
                return
            }
        }
    }
}

