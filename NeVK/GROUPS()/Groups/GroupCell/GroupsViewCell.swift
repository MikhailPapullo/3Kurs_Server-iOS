//
//  GroupsViewCell.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

class GroupsViewCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupAvatar: UIImageView!

    func configure(name: String, avatar: UIImage) {
        groupName.text = name
        groupAvatar.image = avatar
    }
}
