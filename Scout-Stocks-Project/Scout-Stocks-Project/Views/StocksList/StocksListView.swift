//
//  StocksListView.swift
//  Scout-Stocks-Project
//
//  Created by Kevin Hartley on 9/27/24.
//

import SwiftUI

struct StocksListView: View {
    
    @StateObject var viewModel: StocksListViewModel
    @State private var headerText = "Default Results"
    @State var detailPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Section(
                    header: Text(headerText)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                ) {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    } else if viewModel.stockResults.isEmpty {
                        if viewModel.searchText.isEmpty {
                            if !viewModel.isLoading {
                                Text("Unable to retrive stocks")
                            }
                        } else {
                            Text("No stocks match this search")
                        }
                    } else if let stocksError = viewModel.error {
                        Text("Error: " + stocksError.responseString)
                    } else {
                        ForEach(viewModel.stockResults, id: \.self) { stock in
                            NavigationLink(
                                destination: StockDetailsView(
                                    viewModel: StockDetailsViewModel(
                                        with: StocksDataProvider(
                                            endpoint: StocksAPI()
                                        ),
                                        tickerAggregate: stock
                                    )
                                )
                            )
                            {
                                StockCell(stock: stock)
                                    .cornerRadius(14)
                                    .shadow(radius: 14)
                                    .frame(height: 110)
                            }
                        }
                    }
                }
                .padding()
                .textCase(nil)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.sand)
            .toolbar(detailPresented ? .hidden : .visible, for: .tabBar)
            .toolbarBackground(Color.sand, for: .navigationBar)
            .navigationTitle("Stocks")
            .navigationBarTitleDisplayMode(.large)
            .refreshable(action: {
                viewModel.fetchDefaultStocks()
            })
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchText, initial: true) { _, newText  in
                if newText.isEmpty {
                    headerText = "All Results"
                    viewModel.fetchDefaultStocks()
                } else {
                    headerText = "Search Results"
                    viewModel.searchStocks(with: newText)
                }
            }
        }
    }
}
