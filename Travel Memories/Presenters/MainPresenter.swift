//
//  MainPresenter.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation

// к View
protocol MainViewInputProtocol : AnyObject {
    func success()
    func failure()
}

// от View
protocol MainPresenterOutputProtocol: AnyObject {
    
    init(view: MainViewInputProtocol, dataBaseManeger: ModelManager, router: Router, currentID: String)

}


class MainPresenter {
    
}
