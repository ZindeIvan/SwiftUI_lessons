//
//  FriendsIconView.swift
//  VK_client
//
//  Created by Зинде Иван on 7/11/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

@IBDesignable class IconShadowView : UIView {
    
    override class var layerClass: AnyClass{
        return CAShapeLayer.self
    }
    
    @IBInspectable var shadowColor : UIColor = .black {
        didSet{
            updateShadowColor()
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0.8 {
        didSet {
            updateShadowOpasity()
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 6 {
        didSet {
            updateShadowRadius()
        }
    }
    
    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }
    
    private func updateShadowOpasity() {
        layer.shadowOpacity = shadowOpacity
    }
    
    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }
    
    func configureLayer () {
        layer.cornerRadius = frame.height / 2
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
}

class IconView : UIView {
    
    override class var layerClass: AnyClass{
        return CAShapeLayer.self
    }
    
    func configureLayer () {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
