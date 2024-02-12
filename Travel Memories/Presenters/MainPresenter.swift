//
//  MainPresenter.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation

// к View
protocol MainViewOutputProtocol : AnyObject {
    func success()
    func failure()
}

// от View
protocol MainPresenterOutputProtocol: AnyObject {
    
    init(view: MainViewOutputProtocol, modelManager: ModelManager, router: RouterProtocol)
    
    var citys: [CityModel]? { get set }
    
    func addButtonPressed()
    func getAllCitis()
    func cleanAll()
    func deleteCertainObject(id: String)
}



//MARK: - MainPresenterOutputProtocol
class MainPresenter: MainPresenterOutputProtocol {
    
    var citys: [CityModel]?
    
    weak var view: MainViewOutputProtocol?
    let modelManager: ModelManagerProtocol?
    let router: RouterProtocol?
    
    
    required init(view: MainViewOutputProtocol, modelManager: ModelManager, router: RouterProtocol) {
        self.view = view
        self.modelManager = modelManager
        self.router = router
    }
    
    func getAllCitis() {
        modelManager?.getAll(complition: { [weak self] result in
            switch result {
            case .success(let data):
                self?.citys = data
            case .failure(_):
                print("Объект не найден")
            }
        })
    }

    func cleanAll() {
        modelManager?.deleteAll()
        getAllCitis()
    }
    
    func deleteCertainObject(id: String) {
        modelManager?.objectToDelete(id: id) {[weak self] result in
            switch result {
            case .success(let object):
                self?.modelManager?.deleteObjectFromRealm(object: object!)
                self?.view?.success()
            case .failure(_):
                print("Объект не найден")
            }
        }
    }
                                                          
    func addButtonPressed() {
        router?.showAddViewController()
    }  
}
