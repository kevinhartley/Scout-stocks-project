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
    
    func searchStocks(with query: String) async {
        isLoading = true
        error = nil
        
        Task.detached {
            do {
                let stocks = try await self.stocksDataProvider.getAggregateData(for: query)
                await MainActor.run {
                    self.stockResults = [stocks]
                    self.isLoading = false
                }
            } catch {
                guard let stocksError = error as? StocksError else {
                    print("UnknownError: \(error)")
                    return
                }
                
                await MainActor.run {
                    self.error = stocksError
                    self.isLoading = false
                    print("Underlying Issue: \(stocksError)")
                    return
                }
            }
        }
    }
    
    func fetchDefaultStocks() async {
        isLoading = true
        Task.detached {
            do {
                let aggregates = try await self.stocksDataProvider.fetchDefaultStocks()
                await MainActor.run {
                    self.stockResults = aggregates
                    self.isLoading = false
                }
            } catch {
                guard let stocksError = error as? StocksError else {
                    print("UnknownError: \(error)")
                    return
                }
                
                await MainActor.run {
                    self.isLoading = false
                    self.error = stocksError
                    print("Underlying Issue: \(stocksError)")
                    return
                }
            }
        }
    }
}

