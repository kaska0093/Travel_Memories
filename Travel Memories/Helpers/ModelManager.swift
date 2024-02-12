//
//  ModelManager.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift

protocol ModelManagerProtocol {
    
    func getAll(complition: @escaping (Result<[CityModel], Error>) -> Void)
    func saveNewCity(city: CityModel)
    func deleteAll()
    func objectToDelete(id: String, complition: @escaping (Result<CityModel?, Error>) -> Void)
    func deleteObjectFromRealm(object: Object)
}

//MARK: - ModelManagerProtocol
class ModelManager: ModelManagerProtocol {
    
    fileprivate lazy var mainRealm = try! Realm(configuration: migration())

    func getAll(complition: @escaping (Result<[CityModel], Error>) -> Void) {
        
        let model = Array(mainRealm.objects(CityModel.self))
        if !model.isEmpty {
            complition(.success(model))
        } else {
            complition(.failure(ModelManagerError.isEmpty))
        }
    }
    

    
    func objectToDelete(id: String, complition: @escaping (Result<CityModel?, Error>) -> Void) {
        
        let test = NSPredicate(format: "id CONTAINS %@", id)
        if let model = mainRealm.objects(CityModel.self).filter(test).first {
            complition(.success(model))
        } else {
            complition(.failure(ModelManagerError.dontExist))
        }
    }
    
    func deleteObjectFromRealm(object: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }

    
    func saveNewCity(city: CityModel) {
        
        try! mainRealm.write {
            mainRealm.add(city)
        }
    }
    
    func deleteAll() {
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}

//MARK: - Migration
extension ModelManager {
    
    func migration() -> Realm.Configuration {
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        }
        return config
    }
}

extension ModelManager {
    
    enum ModelManagerError: Error {
        case isEmpty
        case dontExist
    }
}
