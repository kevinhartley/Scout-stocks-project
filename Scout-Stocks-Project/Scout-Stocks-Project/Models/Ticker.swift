//
//  StockDetails.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

struct Ticker: Codable, Hashable {
    let ticker: TickerTradeDetails
}

struct TickerTradeDetails: Codable, Hashable {
    let day: Day?
    let ticker: String?
    let todaysChange: Double?
}
