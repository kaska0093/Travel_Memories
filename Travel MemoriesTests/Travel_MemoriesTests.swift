//
//  Travel_MemoriesTests.swift
//  Travel MemoriesTests
//
//  Created by Nikita Shestakov on 21.02.2024.
//

import XCTest
@testable import Travel_Memories

final class Travel_MemoriesTests: XCTestCase {
    //Given
    //When
    //Then

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        func testAddition() {
            let result = 2 + 2
            XCTAssertEqual(result, 4, "Ожидается, что 2 + 2 будет равно 4")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class CityAddVCTests: XCTestCase {
    var cityAddViewController: CityAdd_VC!
    var presenterMock: AddPresenterOutputProtocolMock!
    
    override func setUpWithError() throws {
        super.setUp()
        var window: UIWindow!
        cityAddViewController = CityAdd_VC()
        presenterMock = AddPresenterOutputProtocolMock(view: cityAddViewController,
                                                       modelManager: ModelManager(),
                                                       router: Router(navigationController: UINavigationController()),
                                                       isEditingMode: true)
        cityAddViewController.presenter = presenterMock
        cityAddViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        cityAddViewController = nil
        presenterMock = nil
    }
  
    func testViewDidLoad() {
        cityAddViewController.viewDidLoad()
        presenterMock.saveNewCity(imageOfCity: UIImage(), nameOfCity: "")
        
        XCTAssertTrue(cityAddViewController.view.backgroundColor == .red, "View background color should be red")
        XCTAssertEqual("New city", cityAddViewController.title, "Title should be 'New city'")
        //XCTAssertTrue(cityAddViewController.navigationController?.navigationBar.prefersLargeTitles == true, "Large titles should be preferred")
    }
}

class SceneDelegateTests: XCTestCase {
  
  var window: UIWindow!
  var delegate: SceneDelegate!

    override func setUpWithError() throws {
    super.setUp()
    delegate = SceneDelegate()
    window = UIWindow()
    window.rootViewController = UIViewController()
    delegate.window = window
  }

    override func tearDownWithError() throws {
    window = nil
    delegate = nil
    super.tearDown()
  }

  func testWindow() {
    XCTAssertTrue(delegate.window === window, "SceneDelegate window property should be set to the window")
  }
}


class AddPresenterOutputProtocolMock: AddPresenterOutputProtocol {
    
    required init(view: Travel_Memories.CityAdd_VC, modelManager: Travel_Memories.ModelManagerProtocol, router: Travel_Memories.RouterProtocol, isEditingMode: Bool) {
        
    }
    
    func changeCertainObject(imageOfCity: UIImage?, nameOfCity: String?) {
        //
    }
    
    var citys: Travel_Memories.CityModel?
    
    func setupDataForEdditing() {
        //
    }
    
    var isEditingMode: Bool? = false

    func getMark() {
        // Add implementation as needed for your test
    }

    func saveNewCity(imageOfCity: UIImage?, nameOfCity: String) {
        // Add implementation as needed for your test
    }

    func changeCertainObject(imageOfCity: UIImage?, nameOfCity: String) {
        // Add implementation as needed for your test
    }
    
    // Add more methods as needed...
}


