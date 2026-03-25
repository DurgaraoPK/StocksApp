//
//  StockListViewModelTests.swift
//  StocksApp
//
//  Created by Durgarao on 25/03/26.
//


import XCTest
@testable import StocksApp

@MainActor
final class StockListViewModelTests: XCTestCase {

    var viewModel: StockListViewModel!
    var mockManager: MockStockManager!

    override func setUp() {
        super.setUp()
        mockManager = MockStockManager()
        viewModel = StockListViewModel(repository: mockManager)
    }

    override func tearDown() {
        viewModel = nil
        mockManager = nil
        super.tearDown()
    }

    func testFetchStocks_Data() async {
        
        await viewModel.fetchStocks()

        XCTAssertEqual(viewModel.stocks.count, 2)
        XCTAssertEqual(viewModel.stocks.first?.symbol, "ES=F")
        XCTAssertEqual(viewModel.stocks.first?.name, "S&P Futures")
        XCTAssertEqual(viewModel.stocks.first?.price, 46782.0)
        XCTAssertEqual(viewModel.stocks.first?.changePercent, 10.0)
    }
    

    func testFetchStocks_Success() async {
        
        await viewModel.fetchStocks()

        XCTAssertEqual(viewModel.stocks.count, 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }


    func testFetchStocks_Failure() async {
        
        mockManager.shouldReturnError = true

        await viewModel.fetchStocks()

        XCTAssertTrue(viewModel.stocks.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch stocks. Please try again.")
    }



    func testFilteredStocks_WithSearchText() async {
        
        await viewModel.fetchStocks()
       
        viewModel.searchText = "Dow"

        let result = viewModel.filteredStocks

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Dow Futures")
    }
}
