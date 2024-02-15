//
//  ModelManager.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift

protocol ModelManagerProtocol {
    
    func getModeCities(complition: @escaping (Result<[CityModel], Error>) -> Void)
    func deleteAll()

    //MARK: - citis
    func saveNewCity(city: CityModel)
    func objectToDelete(id: String, complition: @escaping (Result<CityModel?, Error>) -> Void)
    func deleteObjectFromRealm(object: Object)
    //MARK: - user
    func saveUserInfo(name: String?, image: UIImage?)
    func changeUserInfo(name: String?, image: UIImage?)
    func getUserInfo(complition: @escaping (Result<UserAccountInfo, Error>) -> Void)

}

//MARK: - ModelManagerProtocol
class ModelManager: ModelManagerProtocol {

    fileprivate lazy var mainRealm = try! Realm(configuration: migration())

    func getModeCities(complition: @escaping (Result<[CityModel], Error>) -> Void) {
        
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
    //MARK: - user
    
    func saveUserInfo(name: String?, image: UIImage?)  {

        DispatchQueue.main.async {
            try! self.mainRealm.write {

                let newUser = UserAccountInfo()
                newUser.image = image
                newUser.name = name
                self.mainRealm.add(newUser)
            }
        }
    }
    
    
    func changeUserInfo(name: String?, image: UIImage?) {
        print(image)
        print(name)
        DispatchQueue.main.async { [self] in
            
            try! mainRealm.write {
                let person = mainRealm.objects(UserAccountInfo.self).first
                person?.image = image //FIXME:  заходит в блок set
                person?.name = name
            }
        }
    }

    func getUserInfo(complition: @escaping (Result<UserAccountInfo, Error>) -> Void) {
        
        DispatchQueue.main.async {
            if let user = self.mainRealm.objects(UserAccountInfo.self).first {
                print(user)
                if let image = user.image {
                    print(image)
                }
                complition(.success(user))
            }
        }


//        DispatchQueue.main.async { [self] in
//            
//            if let model = mainRealm.objects(UserAccountInfo.self).first {
//          //FIXME: не заходит в блок get
//                complition(.success(model))
//            } else {
//                complition(.failure(ModelManagerError.isEmpty))
//            }
//        }
    }
    
    //MARK: - system
    func deleteAll() {
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}

//MARK: - Migration
extension ModelManager {
    
    func migration() -> Realm.Configuration {
        
        let config = Realm.Configuration(schemaVersion: 8) { migration, oldSchemaVersion in
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
