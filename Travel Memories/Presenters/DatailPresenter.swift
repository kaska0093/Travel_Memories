//
//  DatailPresenter.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 12.02.2024.
//

import Foundation


// к View
protocol DetailViewOutputProtocol : AnyObject {
    func success()
    func failure()
}

// от View
protocol DetailPresenterOutputProtocol: AnyObject {
    
    init(view: DetailViewController, modelManager: ModelManager, router: RouterProtocol)
    
    var citys: [CityModel]? { get set }

}

class DatailPresenter: DetailPresenterOutputProtocol {
    
    
    weak var view: DetailViewController?
    var router: RouterProtocol?
    let modelManager: ModelManagerProtocol!
    
    required init(view: DetailViewController, modelManager: ModelManager, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.modelManager = modelManager
    }
    
    var citys: [CityModel]?   
}
