//
//  StocksDataProvider.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

protocol StocksDataProvidable {
    func fetchDefaultStocks() async throws -> [Aggregate]
    func searchStock(with query: String) async throws -> Ticker
    func getStockDetails(with tickerName: String) async throws -> TickerDetails
    func getAggregateData(for tickerName: String) async throws -> Aggregate
}

class StocksDataProvider: StocksDataProvidable {
    
    private let endpoint: StocksEndpoint
    
    init(endpoint: StocksEndpoint) {
        self.endpoint = endpoint
    }
    
    func fetchDefaultStocks() async throws -> [Aggregate] {
        
        let defaultTickerStrings = ["AAPL", "GOOG", "MSFT", "AMZN", "META"]
        var stocks: [Aggregate] = []
        for ticker in defaultTickerStrings {
            let stock = try await getAggregateData(for: ticker)
            stocks.append(stock)
        }
        return stocks
    }
    
    func searchStock(with query: String) async throws -> Ticker {
        guard let url = URL(string: endpoint.baseURLString + endpoint.tickerPath(with: query)) else {
            throw StocksError.invalidEndpoint
        }

        let result: TickerSnapshotResponse = try await self.load(from: url)

        guard let ticker = result.ticker else {
            throw StocksError.noData
        }

        return ticker
    }
    
    func getStockDetails(with tickerName: String) async throws -> TickerDetails {
        guard let url = URL(string: endpoint.baseURLString + endpoint.stockDetailsPath(with: tickerName)) else {
            throw StocksError.invalidEndpoint
        }
        
        let result: TickerDetails = try await self.load(from: url)
        
        return result
    }
    
    func getAggregateData(for tickerName: String) async throws -> Aggregate {
        
        let today = Date()
        let calendar = Calendar.current
        let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: today) ?? Date()
        
        guard let url = URL(string: endpoint.baseURLString + endpoint.aggregatePath(with: tickerName, startDate: lastWeek, endDate: today)) else {
            throw StocksError.invalidEndpoint
        }
        
        let result: Aggregate = try await self.load(from: url)
        
        return result
    }
}

extension StocksDataProvidable {
    
    func load<D: Decodable>(from url: URL, params: [String: String]? = nil) async throws -> D {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw StocksError.invalidEndpoint
        }
        
        var queryItems = [URLQueryItem(name: "apiKey", value: StocksAPI.apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw StocksError.invalidEndpoint
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            print("Error Response: \(response)")
            let error: StocksError = (response as? HTTPURLResponse)?.statusCode == 429 ? StocksError.tooManyRequests : StocksError.invalidResponse
            throw error
        }
        
        return try JSONDecoder().decode(D.self, from: data)
    }
}
