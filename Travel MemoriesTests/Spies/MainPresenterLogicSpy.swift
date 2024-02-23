//
//  MainPresentationLogicSpy.swift
//  Travel MemoriesTests
//
//  Created by Nikita Shestakov on 22.02.2024.
//

import Foundation

import Foundation
@testable import Travel_Memories

final class MainPresenterLogicSpy: SmallPartMainPresenterOutputProtocol {

    // MARK: - Public Properties
    
    private(set) var isCalledPresentFetchedUsers = false
    
    // MARK: - Public Methods
    func showDetailPressed(index: Int) {
        isCalledPresentFetchedUsers = true
    }
    


  

}
