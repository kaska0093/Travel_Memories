//
//  Assembler.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

protocol AssemblerProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createAddModule(router: RouterProtocol, isEditingMode: Bool, id: String?) -> UIViewController

    func createDetailModule(router: RouterProtocol, city: CityModel) -> UIViewController
}

class Assembler: AssemblerProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let modelManager = ModelManager()
        let presenter = MainPresenter(view: view, modelManager: modelManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAddModule(router: RouterProtocol, isEditingMode: Bool, id: String?) -> UIViewController {
        let view = CityAdd_VC()
        let modelManager = ModelManager()
        if isEditingMode == false {
            let presenter = AddPresenter(view: view, modelManager: modelManager, router: router, isEditingMode: isEditingMode)
            view.presenter = presenter
        } else {
            let presenter = AddPresenter(view: view, modelManager: modelManager, router: router, isEditingMode: isEditingMode, id: id!)
            view.presenter = presenter
        }
        return view
    }
    
    func createDetailModule(router: RouterProtocol, city: CityModel) -> UIViewController {
        let view = DetailViewController()
        let modelManager = ModelManager()
        let presenter = DatailPresenter(view: view, modelManager: modelManager, router: router, city: city)
        view.presenter = presenter
        return view
    }
     
    func createDetailModule() -> UIViewController {
        return MainViewController()
    }
    
    
}
