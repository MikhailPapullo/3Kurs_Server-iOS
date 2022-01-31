//
//  RealmCacheManager.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/20/22.
//

import RealmSwift

class RealCacheManager {
    func saveFriend(friends: [Friend]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
