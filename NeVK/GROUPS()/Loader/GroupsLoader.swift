//
//  GroupsLoader.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/12/21.
//

import UIKit

class GroupsLoader {

    static func iNeedGroups() -> [GroupModel] {
       return [GroupModel(name: "Волшебный Лес", avatar: "VolLes"),
                GroupModel(name: "Северный Полюс", avatar: "SevPol")
        ]
    }
}
