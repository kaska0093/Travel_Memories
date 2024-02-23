//
//  PresenterTests.swift
//  Travel MemoriesTests
//
//  Created by Nikita Shestakov on 22.02.2024.
//

import XCTest
@testable import Travel_Memories

final class PresenterTests: XCTestCase {
    
    var sut: MainPresenter!          
    
    var view: MainViewLogicSpy!
    var modelManager: ModelManager!
    var router: Router!
    
    override func setUpWithError() throws {
        
        view = MainViewLogicSpy()
        modelManager = ModelManager()
        router = Router(navigationController: UINavigationController())
        
        sut = MainPresenter(view: view,
                            modelManager: modelManager,
                                      router: router)
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        view = nil
        modelManager = nil
        router = nil
    }
    
    func testExample() throws {
        sut.getAllCitis()
        sut.showDetailPressed(index: 2)
        XCTAssertTrue(view.isCalledTableViewReload, "Not started viewController.tableReload")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
