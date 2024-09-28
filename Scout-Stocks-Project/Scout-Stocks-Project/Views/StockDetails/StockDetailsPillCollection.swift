//
//  StockDetailsPillCollection.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

struct StockDetailsPillCollection: View {
    var details: (current: Double?, high: Double?, low: Double?, volume: Double?)
    var parentWidth: CGFloat
    
    var body: some View {
        Group {
            Group {
                HStack(alignment: .top) {
                    Spacer()
                    VStack {
                        Text("Current")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(details.current?.rounded(toPlaces: 2).asDollarString ?? "No Current Available")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .shadow(radius: 3)
                        .frame(width: 1)
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Text("High")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(details.high?.rounded(toPlaces: 2).asDollarString ?? "No High Available")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .shadow(radius: 3)
                        .frame(width: 1)
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Text("Low")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(details.low?.rounded(toPlaces: 2).asDollarString ?? "No Low Available")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .shadow(radius: 3)
                        .frame(width: 1)
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Text("Volume")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(String(Int(details.volume ?? 0)))
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding([.top, .bottom])
            }
            .background(
                Rectangle()
                    .fill(Color.sand)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 7)
            )
            .padding([.leading, .trailing])
        }
        .frame(minWidth: parentWidth)
    }
}
