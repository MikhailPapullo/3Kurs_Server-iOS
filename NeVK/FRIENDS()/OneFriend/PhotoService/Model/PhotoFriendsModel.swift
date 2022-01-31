//
//  PhotoFriendsModel.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/22/22.
//

import Foundation

struct PhotoFriends: Codable {
    let response: ResponsePhoto
}

struct ResponsePhoto: Codable {
    let count: Int
    let items: [InfoPhotoFriend]
}

struct InfoPhotoFriend: Codable {
    var sizes: [Size]
    var text: String

    enum CodingKeys: String, CodingKey {
        case sizes
        case text
    }
}

struct Size: Codable {
    let url: String
    let type: SizeType

    enum SizeType: String, Codable {
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}
