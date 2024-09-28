//
//  StocksAPI.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

protocol StocksEndpoint {
    var baseURLString: String { get }
    func tickerPath(with name: String) -> String
    func stockDetailsPath(with name: String) -> String
    func aggregatePath(with tickerName: String, startDate: Date, endDate: Date) -> String
}

struct StocksAPI: StocksEndpoint {
    static var apiKey: String {
        "V_tYFbsCnYjPnTyXdIU8MHgCLgGo8tNM"
    }
    
    var baseURLString: String {
        "https://api.polygon.io"
    }
    
    func tickerPath(with name: String) -> String {
        "/v2/snapshot/locale/us/markets/stocks/tickers/\(name)"
    }
    
    func stockDetailsPath(with name: String) -> String {
        "/v3/reference/tickers/\(name)"
    }
    
    func aggregatePath(with tickerName: String, startDate: Date, endDate: Date) -> String {
        "/v2/aggs/ticker/\(tickerName)/range/1/day/\(startDate.removeTimeStamp)/\(endDate.removeTimeStamp)"
    }
}
