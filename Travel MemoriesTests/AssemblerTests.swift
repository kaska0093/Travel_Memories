//
//  AssemblerTests.swift
//  Travel MemoriesTests
//
//  Created by Nikita Shestakov on 22.02.2024.
//

import XCTest
@testable import Travel_Memories

final class AssemblerTests: XCTestCase {
    var sut: Assembler!
    var presenter:  MainPresenterLogicSpy!


    override func setUpWithError() throws {
        presenter = MainPresenterLogicSpy()
        sut = Assembler()

    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }

    func testExample() throws {
        //FIXME: непонятно что это ниже
        presenter.showDetailPressed(index: 1)

        var vc = sut.createMainModule(router: Router(navigationController: UINavigationController()))
        XCTAssertNotNil(vc, "Error compile new ViewController")
    }

    func testPerformanceExample() throws {
        self.measure(
            metrics: [
              XCTClockMetric(),
              XCTCPUMetric(),
              XCTStorageMetric(),
              XCTMemoryMetric()
            ]
          ) {
              var vc = sut.createMainModule(router: Router(navigationController: UINavigationController()))
        }
    }

}
