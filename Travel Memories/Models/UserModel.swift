//
//  UserModel.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import Foundation
import RealmSwift


class UserAccountInfo: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var userImage: Data? = nil
    
    var image: UIImage? {
        get {
            guard let data = userImage else { return nil }
            return UIImage(data: data as Data)
        }
        set {
            userImage = newValue?.pngData() as Data?
        }
    }
    
    convenience init(userImage: UIImage?, name: String?) {
        self.init()
        self.image = image
        self.name = name
    }
}
