//
//  ModelManager.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift


class ModelManager {
    
    fileprivate lazy var mainRealm = try! Realm(configuration: migration())//migration())

    func getAll() -> [TripsModel] {
        let model = mainRealm.objects(TripsModel.self)
        return Array(model)
    }
    
    func saveNewTrip(trip: TripsModel) {
        try! mainRealm.write {
            mainRealm.add(trip)
        }
    }
}

extension ModelManager {
    func migration() -> Realm.Configuration {
        let config = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        }
        return config
    }
}
