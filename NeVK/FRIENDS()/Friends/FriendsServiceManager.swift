//
//  FriendsServiceManager.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/13/22.
//

import RealmSwift
import Foundation
import UIKit

class FriendsServiceManager {
    
    private var service = FriendService()
    private let imageService = ImageLoader()
    
    var persistence = RealmCacheService()
    
    let cacheKey = "usersExpiry"
    
    func loadFriends(completion: @escaping([FriendsSection]) -> Void) {
        if checkExpiry(key: cacheKey) {
            guard let realm = try? Realm() else { return }
            let friends = realm.objects(Friend.self)
            let friendsArray = Array(friends)
            
            if !friends.isEmpty {
                let sections = formFriendsArray(from: friendsArray)
                completion(sections)
                return
            }
        }
        service.loadFriend { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friend):
                DispatchQueue.global(qos: .background).async {
                    self.persistence.create(friend.response.items)
                }
                let section = self.formFriendsArray(from: friend.response.items)
                self.setExpiry(key: self.cacheKey, time: 10 * 60)
                completion(section)
            case .failure(_):
                return
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        imageService.loadImage(url: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                debugPrint("Error:\(error.localizedDescription)")
            }
        }
    }
}
private extension FriendsServiceManager {
    
    func setExpiry(key: String, time: Double) {
        let date = (Date.init() + time).timeIntervalSince1970
        UserDefaults.standard.set(String(date), forKey: key)
    }
    
    func checkExpiry(key: String) -> Bool {
        let expiryDate = UserDefaults.standard.string(forKey: key) ?? "0"
        let currentDate = String(Date.init().timeIntervalSince1970)
        
        if expiryDate > currentDate {
            return true
        } else {
            return false
        }
    }
    
    func formFriendsArray(from array: [Friend]?) -> [FriendsSection] {
        guard let array = array else {
            return []
        }
        let sorted = sortFriends(array: array)
        return formFriendsSection(array: sorted)

    }
    
    func sortFriends(array: [Friend]) -> [Character: [Friend]] {
        var newArray: [Character: [Friend]] = [:]
        
        for friend in array {
            guard let firstChar = friend.firstName.first else {
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

    func formFriendsSection(array: [Character: [Friend]]) -> [FriendsSection] {
        var sectionsArray: [FriendsSection] = []
        
        for (key, array) in array {
            sectionsArray.append(FriendsSection(key: key, data: array))
        }
        sectionsArray.sort { $0 < $1 }

        return sectionsArray
    }
}
