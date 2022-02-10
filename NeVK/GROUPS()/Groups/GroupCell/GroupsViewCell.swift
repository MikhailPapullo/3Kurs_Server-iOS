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
    
    private let imageService = FriendsServiceManager()

    func configure(group: Group) {
        groupName.text = name
        
        imageService.loadImage(url: group.photo100) { [weak self] image in
            guard let self = self else { return }
            self.groupAvatar.image = image
        }
    }
}
