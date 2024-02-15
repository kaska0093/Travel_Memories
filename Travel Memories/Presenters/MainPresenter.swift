//
//  MainPresenter.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit

// к View
protocol MainViewOutputProtocol : AnyObject {
    func success_Reload_TableView()
    func loadUserInfo()
    func failure()
}

// от View
protocol MainPresenterOutputProtocol: AnyObject {
    
    init(view: MainViewOutputProtocol, modelManager: ModelManager, router: RouterProtocol)
    
    var citys: [CityModel]? { get set }
    var userAccountInfo: UserAccountInfo? { get set }
    
    func addButtonPressed()
    func showDetailPressed()
    func getAllCitis()
    func cleanAll()
    func deleteCertainObject(id: String)
    
    //MARK: - userInfo
    func saveUserInfo(name: String?, image: UIImage?)
    func getUserInfo()
    
}



//MARK: - MainPresenterOutputProtocol
class MainPresenter: MainPresenterOutputProtocol {

    
    
    var citys: [CityModel]?
    var userAccountInfo: UserAccountInfo?

    
    weak var view: MainViewOutputProtocol?
    let modelManager: ModelManagerProtocol?
    let router: RouterProtocol?
    
    
    required init(view: MainViewOutputProtocol, modelManager: ModelManager, router: RouterProtocol) {
        self.view = view
        self.modelManager = modelManager
        self.router = router
    }
    
    //MARK: - Citis
    func getAllCitis() {
        modelManager?.getModeCities(complition: { [weak self] result in
            switch result {
            case .success(let data):
                self?.citys = data
            case .failure(_):
                print("Объект не найден")
                self?.citys = nil
            }
        })
        view?.success_Reload_TableView()
    }

    func cleanAll() {
        modelManager?.deleteAll()
        getAllCitis()
        getUserInfo()
    }
    
    func deleteCertainObject(id: String) {
        modelManager?.objectToDelete(id: id) {[weak self] result in
            switch result {
            case .success(let object):
                self?.modelManager?.deleteObjectFromRealm(object: object!)
                self?.view?.success_Reload_TableView()
            case .failure(_):
                print("Объект не найден")
            }
        }
    }
    //MARK: - UserInfo methods
    
    func saveUserInfo(name: String?, image: UIImage?) {
        print(Thread.current)
        
        let group = DispatchGroup()
        let serialQueue = DispatchQueue(label: "ru.nikita_shestakov-queue")
        let workItem1: DispatchWorkItem?
        if self.userAccountInfo != nil {
            workItem1 = DispatchWorkItem {
                self.modelManager?.changeUserInfo(name: name, image: image)
            }
        } else {
            workItem1 = DispatchWorkItem {
                self.modelManager?.saveUserInfo(name: name, image: image)
            }
        }
        let workItem2 = DispatchWorkItem {
            self.getUserInfo()
        }
        if let workItem1 {
            serialQueue.async(group: group, execute: workItem1)
        }
        serialQueue.async(group: group, execute: workItem2)
        group.notify(queue: DispatchQueue.main) { [self] in
            view?.loadUserInfo()
        }
    }
    
    
    func getUserInfo() {
        
        modelManager?.getUserInfo(complition: { result in
            switch result {
            case .success(let object):

                self.userAccountInfo = object
            case .failure(_):
                print("Объект не найден")
                self.userAccountInfo = nil
            }
        })
    }

    
    
                  
    //MARK: - router methods
    func addButtonPressed() {
        router?.showAddViewController()
    }  
    func showDetailPressed() {
        router?.showDetailViewController()
    }
}
