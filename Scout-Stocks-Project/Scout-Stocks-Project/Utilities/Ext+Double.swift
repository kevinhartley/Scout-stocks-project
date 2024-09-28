//
//  Ext+Double.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import Foundation

extension Double {
    var asString: String? {
        return String(self)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    var asDollarString: String? {
        guard let numString = self.asString else { return nil }
        return "$" + numString
    }
}

