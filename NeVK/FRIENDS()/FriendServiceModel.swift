//
//  FriendServiceModel.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/13/22.
//

import Foundation
import RealmSwift

struct FriendsVK: Decodable {
    let response: ResponseFriends
}

struct ResponseFriends: Decodable {
    let count: Int
    let items: [Friend]
}

class Friend: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var firstName, lastName: String
    @objc dynamic var photo50: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["firstName"]
    }
}
