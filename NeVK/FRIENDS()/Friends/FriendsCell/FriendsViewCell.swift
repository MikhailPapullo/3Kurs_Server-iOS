//
//  FriendsViewCell.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

class FriendsViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendAvatar: CustomPicture!

    
    func configure(model: FriendModel) {
        friendName.text = model.name
        guard let avatar = UIImage(named: model.avatar) else { return }
        friendAvatar.image = avatar
    }
}
