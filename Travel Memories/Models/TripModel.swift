//
//  TripModel.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift

class CityModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var nameOfCity: String!
    @objc dynamic var imageOfCity: NSData?
    // потому что RealmSwift не поддерживает напрямую
    // хранение UIImage в базе данных.
    var image: UIImage? {
        get {
            guard let data = imageOfCity else { return nil }
            return UIImage(data: data as Data)
        }
        set {
            imageOfCity = newValue?.pngData() as NSData?
        }
    }

    let posts = List<TripMode>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(imageOfCity: UIImage?, nameOfCity: String) {
        self.init()
        self.nameOfCity = nameOfCity
        self.image = imageOfCity
    }
}

class TripMode: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var FirstDate: Date?
    @objc dynamic var LastDate: Date?
    @objc dynamic var tripDescription: String?
    dynamic var raiting: Int?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
enum TypeOfTrip {
    case Free
    case Otpusk
    case Komandirovka
}
