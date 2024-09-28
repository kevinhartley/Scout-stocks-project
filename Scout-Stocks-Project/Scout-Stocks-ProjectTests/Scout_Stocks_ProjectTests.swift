//
//  Scout_Stocks_ProjectTests.swift
//  Scout-Stocks-ProjectTests
//
//  Created by Kevin Hartley on 9/27/24.
//

import XCTest
@testable import Scout_Stocks_Project

final class Scout_Stocks_ProjectTests: XCTestCase {
    
    func testStocksSucceed() async throws {
        let dataProvider: StocksDataProvidable = MockStocksDataProvider(endpoint: DummyStocksAPI(), isValid: true, hasData: true)
        
        Task {
            do {
                let response = try await dataProvider.fetchDefaultStocks()
                XCTAssert(!response.isEmpty)
            }
        }
    }
    
    func testStocksFailWithInvalidResponse() async throws {
        let dataProvider: StocksDataProvidable = MockStocksDataProvider(endpoint: DummyStocksAPI(), isValid: false, hasData: true)
        
        Task {
            do {
                let response = try await dataProvider.fetchDefaultStocks()
                XCTAssert(response.isEmpty)
            } catch {
                guard let stocksError = error as? StocksError else {
                    XCTFail()
                    throw error
                }
                XCTAssertEqual(stocksError, StocksError.invalidResponse)
            }
        }
    }
    
    func testStocksFailWithNoData() async throws {
        let dataProvider: StocksDataProvidable = MockStocksDataProvider(endpoint: DummyStocksAPI(), isValid: true, hasData: false)
        
        Task {
            do {
                let response = try await dataProvider.fetchDefaultStocks()
                XCTAssert(response.isEmpty)
            } catch {
                guard let stocksError = error as? StocksError else {
                    XCTFail()
                    throw error
                }
                XCTAssertEqual(stocksError, StocksError.noData)
            }
        }
    }
}
