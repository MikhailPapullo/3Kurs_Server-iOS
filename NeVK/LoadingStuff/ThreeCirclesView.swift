//
//  ThreeCirclesView.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/18/21.
//

//Мертвый код длдя отработки различных вариантов "загрузного экрана с тремя кружлчками". Пока его не удаляю для отработки некотрых элементов анимации.

import UIKit

class ThreeCirclesView: UIView {
    
    let circle1 = UIView(frame: CGRect(x: 10, y: 20, width: 60, height: 60))
    let circle2 = UIView(frame: CGRect(x: 75, y: 20, width: 60, height: 60))
    let circle3 = UIView(frame: CGRect(x: 140, y: 20, width: 60, height: 60))
    
//    let pisitions: [CGRect] = [CGRect(x: 30, y: 20, width: 60, height: 60),
//    CGRect(x: 60, y: 15, width: 70, height: 70),
//    CGRect(x: 60, y: 25, width: 50, height: 50)]
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        circle1.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        circle1.layer.cornerRadius = circle1.frame.width / 2
        
        circle2.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        circle2.layer.cornerRadius = circle1.frame.width / 2
        
        circle3.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        circle3.layer.cornerRadius = circle1.frame.width / 2
        
        addSubview(circle1)
        addSubview(circle2)
        addSubview(circle3)
    }
    
//    func animateCircles() {
//        let disapearAnimation1 = CABasicAnimation(keyPath: "opacity")
//        disapearAnimation1.fromValue = 1
//        disapearAnimation1.toValue = 0
//        disapearAnimation1.duration = 0.5
//        disapearAnimation1.beginTime = CACurrentMediaTime()
//        disapearAnimation1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        disapearAnimation1.fillMode = CAMediaTimingFillMode.backwards
//
//            let disapearAnimation2 = CABasicAnimation(keyPath: "opacity")
//            disapearAnimation2.fromValue = 1
//            disapearAnimation2.toValue = 0
//        disapearAnimation2.duration = 0.5
//        disapearAnimation2.beginTime = CACurrentMediaTime() + 0.6
//            disapearAnimation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//            disapearAnimation2.fillMode = CAMediaTimingFillMode.backwards
//
//            let disapearAnimation3 = CABasicAnimation(keyPath: "opacity")
//            disapearAnimation3.fromValue = 1
//            disapearAnimation3.toValue = 0
//        disapearAnimation3.duration = 0.5
//        disapearAnimation3.beginTime = CACurrentMediaTime() + 1.2
//            disapearAnimation3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//            disapearAnimation3.fillMode = CAMediaTimingFillMode.backwards
//
//        self.circle1.layer.add(disapearAnimation1, forKey: nil)
//        self.circle2.layer.add(disapearAnimation2, forKey: nil)
//        self.circle3.layer.add(disapearAnimation3, forKey: nil)
//    }
//}

//func transitionCircles() {
//    UIView.transition(from: circle1,
//                      to: circle1,
//                      duration: 1,
//                      options: [.transitionCrossDissolve, .repeat, .autoreverse],
//                      completion: nil
//        )
//
//    UIView.transition(from: circle2,
//                      to: circle2,
//                      duration: 1,
//                      options: [.transitionCrossDissolve, .repeat, .autoreverse],
//                      completion: nil
//        )
//    UIView.transition(from: circle3,
//                      to: circle3,
//                      duration: 1,
//                      options: [.transitionCrossDissolve, .repeat, .autoreverse],
//                      completion: nil
//        )
//    }
    
//    func movingCircles() {
//        self.circle1.transform = CGAffineTransform(translationX: 0, y: 20)
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.2,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: [.repeat, .autoreverse],
//                       animations: {self.circle1.transform = .identity
//        },
//        completion: nil)
//
//        self.circle2.transform = CGAffineTransform(translationX: 0, y: 20)
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.7,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: [.curveEaseOut, .repeat, .autoreverse],
//                       animations: {self.circle2.transform = .identity
//        },
//        completion: nil)
//
//        self.circle3.transform = CGAffineTransform(translationX: 0, y: 20)
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.7,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: [.curveEaseOut, .repeat, .autoreverse],
//                       animations: {self.circle3.transform = .identity
//        },
//        completion: nil)
//    }
    func disappearOneByOne() {
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.1,
//                       options: [.repeat, .autoreverse],
//                       animations: {self.circle1.frame.origin.y -= 20
//                       })
        UIView.animate(withDuration: 0.9,
                       delay: 0.0,
                       options: .repeat,
                       animations: { self.circle1.alpha = 0
            
        })
        
        UIView.animate(withDuration: 0.9,
                       delay: 0.15,
                       options: .repeat,
                       animations: { self.circle2.alpha = 0
            
        })
        
        UIView.animate(withDuration: 0.9,
                       delay: 0.30,
                       options: .repeat,
                       animations: { self.circle3.alpha = 0
            
        })
    }
}
