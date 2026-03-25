//
//  StockListViewModelTests.swift
//  StocksApp
//
//  Created by Durgarao on 25/03/26.
//


import XCTest
@testable import StocksApp

@MainActor
final class StockListViewModelTests : XCTestCase {

    func testFetchStocks() async {
        let vm =  StockListViewModel(repository: StockManagerMock())

        await vm.fetchStocks()

        XCTAssertEqual(vm.stocks.count, 1)
    }

    func testSearch() async {
        let vm =  StockListViewModel(repository: StockManagerMock())

        await vm.fetchStocks()
        vm.searchText = "apple"

        XCTAssertEqual(vm.filteredStocks.count, 1)
    }
}
