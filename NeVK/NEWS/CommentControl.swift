//
//  CommentControl.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/11/21.
//

import UIKit

class CommentControl: UIControl {

    private var stackView: UIStackView = UIStackView()
    private var commentImageEmpty: UIImageView = UIImageView()
    private var commentImageFill: UIImageView = UIImageView()
    private var bgView: UIView = UIView()

    private func setupView() {

        self.backgroundColor = .clear

        let imageEmpty = UIImage(systemName: "comment")
        commentImageEmpty.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
        commentImageEmpty.image = imageEmpty
        commentImageEmpty.tintColor = .systemGray

        let imageFill = UIImage(systemName: "comment.fill")
        commentImageFill.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
        commentImageFill.image = imageFill
        commentImageFill.tintColor = .red

        bgView.frame = bounds
        bgView.addSubview(commentImageEmpty)
        self.addSubview(bgView)
    }
}
