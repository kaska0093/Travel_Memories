//
//  TripModel.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift


class UserAccountInfo: Object {
    @objc dynamic var name: String?
    @objc dynamic var userImage: UIImage?
}


// Определение сущности "User"
class TripsModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    
    let posts = List<CityModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
// Определение сущности "Post"
class CityModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var dateOfVisit: Date?
    @objc dynamic var imagesFromTrip: [UIImage]?
    @objc dynamic var content = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


//
//// Пример использования модели
//func exampleUsage() {
//    let realm = try! Realm()
//    // Создание пользователя
//    let user = User()
//    
//    user.name = "John Doe"
//    
//    // Создание постов и добавление их пользователю
//    let post1 = Post()
//    post1.content = "Hello, World!"
//    user.posts.append(post1)
//    let post2 = Post()
//    post2.content = "Realm is awesome!"
//    user.posts.append(post2)
//    // Сохранение пользователя и постов в Realm
//    try! realm.write {
//        realm.add(user)
//    }
//    // Получение всех пользователей из Realm
//    let users = realm.objects(User.self)
//    for user in users {
//        print("User: \(user.name)")
//        for post in user.posts {
//            print("Post: \(post.content)")
//        }
//    }
//}
