//
//  ViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/18/21.
//

// Так же мертвый код нужен для отработки различных видов анимациию. Пока не удаляю.

import UIKit

class Loading: UIViewController {

//    let spinningCircleView = SpinningCircleView()
    let threeCirclesView = ThreeCirclesView()
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
//        configureSpinningCircleView()
        configureThreeCircles()
    }
    
    private func configure() {
        view.backgroundColor = .systemBlue
    }
    
//    private func configureSpinningCircleView() {
//        spinningCircleView.frame = CGRect(x: view.center.x - 50, y: 100, width: 100, height: 100)
//        view.addSubview(spinningCircleView)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
//    }
    
    private func configureThreeCircles() {
        view.addSubview(threeCirclesView)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        NSLayoutConstraint.activate([
            threeCirclesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            threeCirclesView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            threeCirclesView.heightAnchor.constraint(equalToConstant: 100),
            threeCirclesView.widthAnchor.constraint(equalToConstant: 200)
        ])
    
//    @objxfcc func viewTapped() {
//        spinningCircleView.animate()
        
// threeCirclesView.animateCircles()
//        threeCirclesView.transitionCircles()
//        threeCirclesView.movingCircles()
        threeCirclesView.disappearOneByOne()
    }
}
