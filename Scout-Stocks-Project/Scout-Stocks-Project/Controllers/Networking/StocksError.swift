//
//  StocksError.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

enum StocksError: Error {
    case invalidResponse
    case invalidEndpoint
    case noData
    case serializationError
    case tooManyRequests
    
    var responseString: String {
        switch self {
        case .invalidResponse:
            return "Invalid Response"
        case .invalidEndpoint:
            return "Invalid Endpoint"
        case .noData:
            return "No Data"
        case .serializationError:
            return "Serialization Error"
        case .tooManyRequests:
            return "Too Many Requests"
        }
    }
}
