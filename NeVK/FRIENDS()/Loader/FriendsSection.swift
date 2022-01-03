//
//  FriendSection.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/8/21.
//

struct FriendsSection: Comparable {

    var key: Character
    var data: [FriendModel]

    static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key == rhs.key
    }
}
