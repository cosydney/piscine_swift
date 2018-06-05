//
//  Shape.swift
//  Motion
//
//  Created by Sydney COHEN on 6/5/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import Foundation
import UIKit

class Shape: UIView {
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var size : CGFloat = 100
    var isCircle = false
    init(point: CGPoint, maxwidth: CGFloat, maxheight: CGFloat ) {
        var x = point.x
        var y = point.y
        
        // form shouldnt be able to go out of scope
        if x+size/2 > maxwidth {
            x -= size/2
        }
        if y+size/2 > maxheight {
            y -= size/2
        }
        
        // generate circle or square
        let random = Int(arc4random_uniform(2))
        switch random {
        case 0 :
            super.init(frame: CGRect(x: x, y: y, width: size, height: size))
            self.layer.cornerRadius = size/2
            self.isCircle = true
        default:
            super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        }
        self.backgroundColor = generateRandomColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }

    override var collisionBoundingPath: UIBezierPath {
        if self.isCircle {
            let radius = min(bounds.size.width, bounds.size.height) / 2.0
            return UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        }
        else {
            var rect = bounds
            rect.origin.x -= rect.size.width / 2
            rect.origin.y -= rect.size.height / 2
            return UIBezierPath(rect: rect)
        }

    }
}


