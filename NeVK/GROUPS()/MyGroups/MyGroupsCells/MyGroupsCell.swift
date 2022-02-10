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
    
    private let imageService = FriendsServiceManager()
    
    func configure(group: Group) {
        myGroupName.text = group.name
        
        imageService.loadImage(url: group.photo100) { [weak self] image in
            guard let self =  self else { return }
            self.myGroupAvatar.image = image
        }
    }
}
