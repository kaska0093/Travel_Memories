//
//  AddPresenter.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 10.02.2024.
//

import UIKit

protocol AddViewOuputProtocol {
    func success()
    func failure()
    func setMark(isEditingMode: Bool?)
}

protocol AddPresenterOutputProtocol {
    init(view: AddViewController, modelManager: ModelManagerProtocol, router: RouterProtocol, isEditingMode: Bool)
    func saveNewCity(imageOfCity: UIImage?, nameOfCity: String)
    func getMark()
    func changeCertainObject(imageOfCity: UIImage?, nameOfCity: String?)
    
    var citys: CityModel? { get set }
    func setupDataForEdditing()

    
}

class AddPresenter: AddPresenterOutputProtocol {
    
    var citys: CityModel?
    
    func setupDataForEdditing() {
        modelManager.specificObject(id: id!) { result in
            switch result {
            case .success(let finedObject):
                self.citys = finedObject
            case .failure(_):
                print("Объект не найден")
            }
        }
    }
    
    func getMark() {
        view?.setMark(isEditingMode: isEditingMode)
    }
    func changeCertainObject(imageOfCity: UIImage?, nameOfCity: String?) {
        
        guard let id = id else { return }
        modelManager.specificObject(id: id) { result in
            switch result {
            case .success(let finedObject):
                self.modelManager.changeModelCities(object: finedObject!, newName: nameOfCity, image: imageOfCity)
                self.router?.popToRoot()
            case .failure(_):
                print("Объект не найден")
                self.router?.popToRoot()
            }
        }
    }

    
    
    func saveNewCity(imageOfCity: UIImage?, nameOfCity: String) {
        modelManager.saveNewCity(city: CityModel(imageOfCity: imageOfCity, nameOfCity: nameOfCity))
        modelManager.getModeCities { _ in  }
        router?.popToRoot()
    }
    
    weak var view: AddViewController?
    var router: RouterProtocol?
    let modelManager: ModelManagerProtocol!
    let isEditingMode: Bool?
    let id: String?
    
    required init(view: AddViewController, modelManager: ModelManagerProtocol, router: RouterProtocol, isEditingMode: Bool) {
        self.view = view
        self.modelManager = modelManager
        self.router = router
        self.isEditingMode = isEditingMode
        self.id = nil
    }
    required init(view: AddViewController, modelManager: ModelManagerProtocol, router: RouterProtocol, isEditingMode: Bool, id: String) {
        self.view = view
        self.modelManager = modelManager
        self.router = router
        self.isEditingMode = isEditingMode
        self.id = id
        setupDataForEdditing()
    }
}
