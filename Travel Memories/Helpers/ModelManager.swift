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
    
    /// Функция для поиска конкретного объекта типа CityModel
    /// - Parameters:
    ///   - id: id объекта для поиска
    ///   - complition: найденный объект/ ошибка о его отсутвии в БД
    func specificCity(id: String, complition: @escaping (Result<CityModel?, Error>) -> Void)
    func changeModelCities(object: CityModel, newName: String?, image: UIImage?)

    func deleteObjectFromRealm(object: Object)
    //MARK: - user
    func saveUserInfo(name: String?, image: UIImage?)
    func changeUserInfo(name: String?, image: UIImage?)
    func getUserInfo(complition: @escaping (Result<UserAccountInfo, Error>) -> Void)
    
    //MARK: - Trip
    func addTrip(object: CityModel, startData: Date, end: Date) 
    func changeTrip(id: String, currentPlace: String?, rating: Int?, comment: String?, typeOfTrip: String?)
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
    
    func changeModelCities(object: CityModel, newName: String?, image: UIImage?) {

            try! mainRealm.write {
                object.nameOfCity = newName
                object.image = image
            }
    }
    
    func specificCity(id: String, complition: @escaping (Result<CityModel?, Error>) -> Void) {
        
        let test = NSPredicate(format: "id CONTAINS %@", id)
        if let object = mainRealm.objects(CityModel.self).filter(test).first {
            complition(.success(object))
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
    
    //MARK: - Action with UserInfo
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

        DispatchQueue.main.async { [self] in
            try! mainRealm.write {
  
                let person = mainRealm.objects(UserAccountInfo.self).first
                person?.image = image
                person?.name = name
            }
        }
    }

    func getUserInfo(complition: @escaping (Result<UserAccountInfo, Error>) -> Void) {
        
        DispatchQueue.main.async {
            if let user = self.mainRealm.objects(UserAccountInfo.self).first {
                complition(.success(user))
            } else {
                complition(.failure(ModelManagerError.isEmpty))
            }
        }
    }
    
    //MARK: - Trip
            
    func addTrip(object: CityModel, startData: Date, end: Date) {
            try! mainRealm.write {
                object.posts.append(TripModel(firstDate: startData, lastDate: end))
            }
    }
    
    func changeTrip(id: String, currentPlace: String?, rating: Int?, comment: String?, typeOfTrip: String?) {
        try! mainRealm.write {
            
            let test = NSPredicate(format: "id CONTAINS %@", id)
            if let object = mainRealm.objects(TripModel.self).filter(test).first {
                print(object)
                if let currentPlace {
                    object.currentPlaces.append(currentPlace)
                }
                if let rating {
                    object.raiting = rating
                }
                if let comment {
                    object.tripDescription = comment
                }
                if let typeOfTrip {
                    object.typeOfTrip = typeOfTrip
                }
            }
        }
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
        
        let config = Realm.Configuration(schemaVersion: 14) { migration, oldSchemaVersion in
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
