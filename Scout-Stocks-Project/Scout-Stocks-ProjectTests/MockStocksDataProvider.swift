//
//  MockStocksDataProvider.swift
//  Scout-Stocks-ProjectTests
//
//  Created by Kevin Hartley on 9/28/24.
//

import Foundation
@testable import Scout_Stocks_Project

class MockStocksDataProvider: StocksDataProvidable {
    
    let endpoint: StocksEndpoint
    let isValid: Bool
    let hasData: Bool
    
    init(endpoint: StocksEndpoint, isValid: Bool, hasData: Bool) {
        self.endpoint = endpoint
        self.isValid = isValid
        self.hasData = hasData
    }
    
    let dummyAggregateData = [
        Aggregate(ticker: "TestTicker1", results: [Day(c: 0, h: 0, l: 0, v: 0), Day(c: 1, h: 1, l: 1, v: 1)]),
        Aggregate(ticker: "TestTicker2", results: [Day(c: 0, h: 0, l: 0, v: 0), Day(c: 1, h: 1, l: 1, v: 1)]),
        Aggregate(ticker: "TestTicker3", results: [Day(c: 0, h: 0, l: 0, v: 0), Day(c: 1, h: 1, l: 1, v: 1)])
    ]
    
    let dummyTickerDetails = TickerDetails(results: TickerDetailsResponse(name: "TestDame", ticker: "TestTicker1", locale: "TestLocal", address: nil, branding: Branding(logo_url: nil)))
    
    let dummyTickerSnapshot = Ticker(ticker: TickerTradeDetails(day: Day(c: 0, h: 0, l: 0, v: 0), ticker: "TestTicker1", todaysChange: 0))
    
    var dummyError: StocksError?
    
    func fetchDefaultStocks() async throws -> [Aggregate] {
        if isValid {
            if hasData {
                return dummyAggregateData
            } else {
                throw StocksError.noData
            }
        } else {
            throw StocksError.invalidResponse
        }
    }
    
    func searchStock(with query: String) async throws -> Ticker {
        if isValid {
            if hasData {
                return dummyTickerSnapshot
            } else {
                throw StocksError.noData
            }
        } else {
            throw StocksError.invalidResponse
        }
    }
    
    func getStockDetails(with tickerName: String) async throws -> TickerDetails {
        if isValid {
            if hasData {
                return dummyTickerDetails
            } else {
                throw StocksError.noData
            }
        } else {
            throw StocksError.invalidResponse
        }
    }
    
    func getAggregateData(for tickerName: String) async throws -> Aggregate {
        if isValid {
            if let data = dummyAggregateData.first {
                return data
            } else {
                throw StocksError.noData
            }
        } else {
            throw StocksError.invalidResponse
        }
    }
}
