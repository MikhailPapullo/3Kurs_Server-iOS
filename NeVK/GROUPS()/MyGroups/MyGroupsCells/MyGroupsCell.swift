//
//  MyGroupsCell.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var myGroupName: UILabel!
    @IBOutlet weak var myGroupAvatar: UIImageView!
    
    func configure(name: String, avatar: UIImage) {
        myGroupName.text = name
        myGroupAvatar.image = avatar
    }
}
