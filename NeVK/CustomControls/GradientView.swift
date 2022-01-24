//
//  GradientView.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/7/21.
//

import UIKit

@IBDesignable class GradientView: UIView {
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
           updateColor()
        }
    }
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            updateColor()
        }
    }
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
           updateLocations()
        }
    }
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
           updateLocations()
        }
    }
    @IBInspectable var startPoint: CGPoint = .init(x: 1, y: 0) {
        didSet {
            updateEndPoint()
        }
    }
    @IBInspectable var endPoint: CGPoint = .init(x: 1, y: 0) {
        didSet {
           updateEndPoint()
        }
    }
    
    func updateLocations() {
        self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
    }
    
    func updateColor() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    
    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    
    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}
