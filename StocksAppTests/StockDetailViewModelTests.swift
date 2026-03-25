//
//  StockDetailViewModelTests.swift
//  StocksApp
//
//  Created by Durgarao on 25/03/26.
//

import XCTest
@testable import StocksApp

@MainActor
final class StockDetailViewModelTests: XCTestCase {

    var viewModel: StockDetailViewModel!
    var mockManager: MockStockManager!
    

    override func setUp() {
        super.setUp()
        mockManager = MockStockManager()
        viewModel = StockDetailViewModel(repository: mockManager, symbol: "YM=F")
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertNil(viewModel.detail)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchDetails_Success() async {
        
        await viewModel.fetchDetails()

        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchDetails() async {

        await viewModel.fetchDetails()

        // Basic validation 
        XCTAssertEqual(viewModel.detail?.symbol, "YM=F")
        XCTAssertEqual(viewModel.detail?.description, "Dow Futures")
        XCTAssertEqual(viewModel.detail?.marketCap, 100)
        XCTAssertEqual(viewModel.detail?.peRatio, 10)
    }
}
