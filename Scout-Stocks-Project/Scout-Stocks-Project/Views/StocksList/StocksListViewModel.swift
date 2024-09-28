//
//  StocksListViewModel.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

@MainActor
class StocksListViewModel: ObservableObject {
    
    @Published var stockResults: [Aggregate] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var error: StocksError?
    
    private var stocksDataProvider: StocksDataProvidable
    
    init(with stocksDataProvider: StocksDataProvidable) {
        self.stocksDataProvider = stocksDataProvider
    }
    
    func searchStocks(with query: String) {
        isLoading = true
        Task {
            error = nil
            do {
                let stocks = try await stocksDataProvider.getAggregateData(for: query)
                self.stockResults = [stocks]
                self.isLoading = false
            } catch {
                guard let stocksError = error as? StocksError else {
                    print("UnknownError: \(error)")
                    return
                }
                self.error = stocksError
                self.isLoading = false
                print("Underlying Issue: \(stocksError)")
                return
            }
        }
    }
    
    func fetchDefaultStocks() {
        isLoading = true
        Task {
            do {
                let aggregates = try await stocksDataProvider.fetchDefaultStocks()
                self.stockResults = aggregates
                self.isLoading = false
            } catch {
                guard let stocksError = error as? StocksError else {
                    print("UnknownError: \(error)")
                    return
                }
                
                self.error = stocksError
                self.isLoading = false
                print("Underlying Issue: \(stocksError)")
                return
            }
        }
    }
}

