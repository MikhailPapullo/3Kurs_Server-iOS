//
//  FriendModel.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

struct FriendModel {
    let name: String
    let avatar: String
    let avatar2: String
    let picture: UIImage
    let picture2: UIImage
    var friendPictures: [UIImage] = []
    
    init(name: String, avatar: String, avatar2: String, friendPictures:[String]) {
        self.name = name
        self.avatar = avatar
        self.avatar2 = avatar2
        
        picture = UIImage(named: avatar) ?? UIImage()
        picture2 = UIImage(named: avatar2) ?? UIImage()
        
        for friendPicture in friendPictures {
            guard let avatar = UIImage(named: friendPicture) else { continue }
            self.friendPictures.append(avatar)
        }
    }
}
