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

    let posts = List<TripModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(imageOfCity: UIImage?, nameOfCity: String) {
        self.init()
        self.nameOfCity = nameOfCity
        self.image = imageOfCity
    }
}

class TripModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var firstDate: Date?
    @objc dynamic var lastDate: Date?
    @objc dynamic var tripDescription: String?
    @objc dynamic var typeOfTrip: String? = TypeOfTrip.Free.rawValue
    @objc dynamic var raiting: Int = 0
    let currentPlaces = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(firstDate: Date, lastDate: Date) { //tripDescription: String?,     rating: Int, typeOfTrip: TypeOfTrip?)

        self.init()
        self.firstDate = firstDate
        self.lastDate = lastDate
        //self.tripDescription = tripDescription
        //self.raiting = rating
        //self.typeOfTrip = typeOfTrip?.rawValue
    }
}
enum TypeOfTrip: String {
    case Dont_choose
    case Free
    case Otpusk
    case Komandirovka
}
