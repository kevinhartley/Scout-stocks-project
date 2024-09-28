//
//  DummyStocksAPI.swift
//  Scout-Stocks-ProjectTests
//
//  Created by Kevin Hartley on 9/28/24.
//

import Foundation
@testable import Scout_Stocks_Project

struct DummyStocksAPI: StocksEndpoint {
    var baseURLString: String = ""
    
    func tickerPath(with name: String) -> String {
        ""
    }
    
    func stockDetailsPath(with name: String) -> String {
        ""
    }
    
    func aggregatePath(with tickerName: String, startDate: Date, endDate: Date) -> String {
        ""
    }
}
