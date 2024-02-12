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
}

protocol AddPresenterOutputProtocol {
    init(view: AddViewController, modelManager: ModelManagerProtocol, router: RouterProtocol)
    func saveNewCity(imageOfCity: UIImage?, nameOfCity: String)
}

class AddPresenter: AddPresenterOutputProtocol {
    
    func saveNewCity(imageOfCity: UIImage?, nameOfCity: String) {
        modelManager.saveNewCity(city: CityModel(imageOfCity: imageOfCity, nameOfCity: nameOfCity))
        modelManager.getAll { _ in  }
        router?.popToRoot()
    }
    
    weak var view: AddViewController?
    var router: RouterProtocol?
    let modelManager: ModelManagerProtocol!
    
    required init(view: AddViewController, modelManager: ModelManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.modelManager = modelManager
        self.router = router
    }
}
