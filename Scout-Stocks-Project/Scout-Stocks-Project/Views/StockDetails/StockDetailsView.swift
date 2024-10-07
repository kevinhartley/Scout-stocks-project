//
//  StockDetailsView.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI
import Charts

struct StockDetailsView: View {
    
    @ObservedObject var viewModel: StockDetailsViewModel
    @State var number = 0
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                } else {
                    ZStack(alignment: .bottomLeading) {
                        VStack {
                            Text("Past 5 Business Days")
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing, .top])
                            Chart(viewModel.aggregateDetails?.results ?? [], id: \.self) { aggregate in
                                LineMark(x: .value("Day", "$" + String(aggregate.c.rounded(toPlaces: 2))), y: .value("Price", aggregate.c))
                            }
                            .frame(height: 300)
                            .padding([.leading, .trailing, .bottom], 20)
                        }
                        .background(
                            Rectangle()
                                .fill(Color.white.opacity(0.15))
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 7)
                        )
                        .padding([.bottom], 60)
                        .padding([.leading, .trailing], 7)
                        
                        Group {
                            VStack {
                                Text(viewModel.stockDetails?.results.address?.city ?? "No Stock City")
                                    .font(.title2)
                                    .bold()
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                Text(viewModel.stockDetails?.results.address?.state ?? (viewModel.stockDetails?.results.locale ?? "No Stock Local"))
                                    .font(.title3)
                                    .bold()
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(10)
                        }
                        .frame(alignment: .bottomLeading)
                        .background(
                            Rectangle()
                                .fill(Color.sand)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 7)
                        )
                        .padding([.leading, .trailing], 15)
                    }
                    
                    StockDetailsPillCollection(
                        details: (
                            current: viewModel.aggregateDetails?.results.last?.c,
                            high: viewModel.aggregateDetails?.results.last?.h,
                            low: viewModel.aggregateDetails?.results.last?.l,
                            volume: viewModel.aggregateDetails?.results.last?.v
                        ),
                        parentWidth: proxy.size.width
                    )
                }
            }
            .onAppear(perform: {
                Task {
                    await viewModel.getstock(with: viewModel.aggregateDetails?.ticker ?? "")
                }
            })
            .navigationTitle(viewModel.stockDetails?.results.name ?? "No Stock Name")
            .background(Color.sand)
            .toolbarBackground(Color.sand, for: .navigationBar)
        }
    }
}
