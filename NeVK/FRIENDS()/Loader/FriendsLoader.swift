//
//  FriendsLoader.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/8/21.
//

class FriendsLoader {
    static var friends = [
        FriendModel(name: "Кеша", avatar: "kesha1", avatar2: "kesha2", friendPictures: ["kesha1", "kesha2", "kesha3", "kesha4", "kesha5", "kesha6"]),
        FriendModel(name: "Тучка", avatar: "tuchka1", avatar2: "tuchka2", friendPictures: ["tuchka1", "tuchka2", "tuchka3", "tuchka4", "tuchka5", "tuchka6"]),
        FriendModel(name: "Лисичка", avatar: "lisichka1", avatar2: "lisichka2", friendPictures: [ "lisichka1", "lisichka2", "lisichka3", "lisichka4", "lisichka5", "lisichka6"])
    ]

    static func iNeedFriends() -> [FriendsSection] {
        let sortedArray = sortFriends(array: friends)
        let sectionsArray = formFriendsSection(array: sortedArray)
        return sectionsArray
    }


    static func sortFriends(array: [FriendModel]) -> [Character: [FriendModel]] {
        var newArray: [Character: [FriendModel]] = [:]
        
        for friend in array {
            guard let firstChar = friend.name.first else {
                continue
            }

            guard var array = newArray[firstChar] else {
                let newValue = [friend]
                newArray.updateValue(newValue, forKey: firstChar)
                continue
            }

            array.append(friend)
            
            newArray.updateValue(array, forKey: firstChar)
        }
        return newArray
    }

    static func formFriendsSection(array: [Character: [FriendModel]]) -> [FriendsSection] {
        var sectionsArray: [FriendsSection] = []
        
        for (key, array) in array {
            sectionsArray.append(FriendsSection(key: key, data: array))
        }
        sectionsArray.sort { $0 < $1 }

        return sectionsArray
    }
}

