//
//  VKEntity.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/24/22.
//

import Foundation
import RealmSwift

class VKEntity: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo_50 = Data()
}
