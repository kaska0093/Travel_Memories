//
//  Router.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblerProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
//    func showDetail(comment: Comment?)
//    func popToRoot()
}

class Router: RouterProtocol {
    

    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblerProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    
}
