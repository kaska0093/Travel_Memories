//
//  MainViewLogicSpy.swift
//  Travel MemoriesTests
//
//  Created by Nikita Shestakov on 22.02.2024.
//

import Foundation


import Foundation
@testable import Travel_Memories

final class MainViewLogicSpy: MainViewOutputProtocol {
    
    // MARK: - Public Methods
    func success_Reload_TableView() {
        isCalledTableViewReload = true
    }
    
    func loadUserInfo() {
        //
    }
    
    func failure() {
        //
    }
    
  
  // MARK: - Public Properties
  
  private(set) var isCalledTableViewReload = false
  

}
