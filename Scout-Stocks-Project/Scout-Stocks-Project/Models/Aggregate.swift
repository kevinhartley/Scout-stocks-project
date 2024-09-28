//
//  Stock.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

struct Aggregate: Codable, Hashable {
    let ticker: String
    let results: [Day]
}

struct Day: Codable, Hashable {
    let c: Double
    let h: Double
    let l: Double
    let v: Double
}
