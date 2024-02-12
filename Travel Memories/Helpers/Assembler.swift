//
//  Assembler.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

protocol AssemblerProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol) -> UIViewController  //(comment: Comment?,  router: RouterProtocol)
}

class Assembler: AssemblerProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let modelManager = ModelManager()
        let presenter = MainPresenter(view: view, modelManager: modelManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(router: RouterProtocol) -> UIViewController {
        let view = AddViewController()
        let modelManager = ModelManager()
        let presenter = AddPresenter(view: view, modelManager: modelManager, router: router)
        view.presenter = presenter
        return view
    }
     
    func createDetailModule() -> UIViewController {
        return MainViewController()
    }
    
    
}
