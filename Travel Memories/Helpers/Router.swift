//
//  Router.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

protocol RouterMainProperties {
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblerProtocol? { get set }
}

protocol RouterProtocol: RouterMainProperties {
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerProtocol)
    init(navigationController: UINavigationController)


    func initialViewController()
    func showAddViewController()
    func showDetailViewController()
    func popToRoot()
}

class Router: RouterProtocol {

    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerProtocol?
    
    required init(navigationController: UINavigationController, assemblyBuilder: AssemblerProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func showAddViewController() {
        
        if let navigationController = navigationController {
            guard let addVC = assemblyBuilder?.createAddModule(router: self) else { return }
            navigationController.pushViewController(addVC, animated: true)
        }
    }
    
    func showDetailViewController() {
        if let navigationController = navigationController {
            guard let detailVC = assemblyBuilder?.createDetailModule(router: self) else { return }
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
    
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
