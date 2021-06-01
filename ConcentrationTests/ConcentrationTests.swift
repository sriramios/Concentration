//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by sriram on 01/06/21.
//

import XCTest
@testable import Concentration

class ConcentrationTests: XCTestCase {

    var presenter: CardsViewPresenter?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = CardsViewPresenter()
        presenter?.interactor = CardsViewInteractor(presenter!)
        presenter?.requestForCards()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCardGeneration()  {
        assert(presenter!.currentCards.count == Constants.CardsConfig.numberOfpairs * 2, "Card generation failure")
    }
    
    func testCardSelection()  {
        presenter?.restart()
        assert(presenter!.status == .idle, "status")
        presenter?.didSelectItem(indexPath: IndexPath(row: 1, section: 1))
        assert(presenter!.status != .idle, "single card seletion failure")
    }

    func testCardDoubleSelection()  {
        presenter?.restart()
        assert(presenter!.status == .idle, "status")
        presenter?.didSelectItem(indexPath: IndexPath(row: 1, section: 1))
        presenter?.didSelectItem(indexPath: IndexPath(row: 2, section: 1))
        assert(presenter?.status == GameState.twoCard(firstIndexPath:  IndexPath(row: 1, section: 1), secondIndexPath:  IndexPath(row: 2, section: 1)), "double card seletion failure")
    }
    
    func testCardTimer()  {
        presenter?.restart()
        assert(presenter!.status == .idle, "Card generation failure")
        presenter?.didSelectItem(indexPath: IndexPath(row: 1, section: 1))
        presenter?.didSelectItem(indexPath: IndexPath(row: 2, section: 1))
        assert(presenter?.timer != nil, "Card generation failure")

    }
    
}
