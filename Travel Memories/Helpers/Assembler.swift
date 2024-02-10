//
//  Assembler.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

protocol AssemblerProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule() -> UIViewController  //(comment: Comment?,  router: RouterProtocol)
}

class Assembler: AssemblerProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        // внедрение зависимостей
        // создаются не внутри сущностей, а снаружи
        // делаем инъекцию извне
        let view = MainViewController()
        //let networkService = NetworkService()
        //let presenter = MainPresenter(view: view, networkServise: networkService, router: router)//инжект снаружи для возможности тестирования
        // и SOLID так говорит
        //view.presenter = presenter
        return view
    }
    
    func createDetailModule() -> UIViewController {
        return MainViewController()
    }
    
    
}
