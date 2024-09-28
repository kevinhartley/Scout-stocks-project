//
//  StockCell.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

struct StockCell: View {
    
    let stock: Aggregate
    
    var body: some View {
        HStack {
            Spacer()
            Text(stock.ticker)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(Color.black)
                .padding()
            
            Text("Current price: $" + (stock.results.first?.c.asString ?? "No Current"))
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
        .background(Color.sand)
    }
}

