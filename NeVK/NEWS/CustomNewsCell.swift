//
//  CustomNewsCell.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/11/21.
//

import UIKit

class CustomNewsCell: UITableViewCell {
    
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    
    func configure(name: String, image: UIImage) {
        newsName.text = name
        newsPhoto.image = image
    }
}
