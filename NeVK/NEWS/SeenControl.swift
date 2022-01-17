//
//  SeenControl.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/12/21.
//

import UIKit

class SeenControl: UIControl {
    var seenCount: Int = 0
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onClick))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1

        return recognizer
    }()

    private var stackView: UIStackView = UIStackView()
    private var seenLable: UILabel = UILabel()
    private var bgView: UIView = UIView()

    private func setupView() {

        self.backgroundColor = .clear

        seenLable.frame = CGRect(x: self.frame.size.width - 8, y: 19, width: 12, height: 15)
        seenLable.text = String(seenCount)
        seenLable.textAlignment = .center
        seenLable.textColor = .systemBlue
        seenLable.font = UIFont.systemFont(ofSize: 17)

        bgView.frame = bounds
        bgView.addSubview(seenLable)
        self.addSubview(bgView)
    }

    @objc func onClick() {
        if seenCount == 0 {
            self.seenLable.text = "1"
            seenCount = 1
        } else {
            self.seenLable.text = "0"
            seenCount = 0
        }

        seenLable.text = String(seenCount)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
        addGestureRecognizer(tapGestureRecognizer)
    }
}
