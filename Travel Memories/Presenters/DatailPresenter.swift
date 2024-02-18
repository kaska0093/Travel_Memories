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
    
    func loadTripInfo()
}

// от View
protocol DetailPresenterOutputProtocol: AnyObject {
    
    init(view: DetailViewController, modelManager: ModelManager, router: RouterProtocol, city: CityModel)
    
    var city: CityModel? { get set }
    var trip: TripModel? { get set }
    func setTrip(index: Int)
    func changeDataOfTrip(currentPlace: String?, rating: Int?, comment: String?, typeOfTrip: String?)
}

class DatailPresenter: DetailPresenterOutputProtocol {
    
    var city: CityModel?
    var trip: TripModel?

    
    weak var view: DetailViewController?
    var router: RouterProtocol?
    let modelManager: ModelManagerProtocol!
    
    required init(view: DetailViewController, modelManager: ModelManager, router: RouterProtocol, city: CityModel) {
        self.view = view
        self.router = router
        self.modelManager = modelManager
        self.city = city
        print(city)
    }
    
    func setTrip(index: Int) {
        self.trip = city?.posts[index]
        view?.loadTripInfo()
    }
    
    func changeDataOfTrip(currentPlace: String?, rating: Int?, comment: String?, typeOfTrip: String?) {
        modelManager.changeTrip(id: self.trip!.id, currentPlace: currentPlace, rating: rating, comment: comment, typeOfTrip: typeOfTrip)
    }
}
