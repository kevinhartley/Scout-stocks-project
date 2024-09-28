//
//  TickerDetails.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

struct TickerDetails: Codable, Hashable {
    let results: TickerDetailsResponse
}

struct TickerDetailsResponse: Codable, Hashable {
    let name: String?
    let ticker: String?
    let locale: String?
    let address: TickerAddressDetails?
    let branding: Branding
}

struct TickerAddressDetails: Codable, Hashable {
    let city: String?
    let state: String?
}

struct Branding: Codable, Hashable {
    let logo_url: String?
}
