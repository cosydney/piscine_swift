//
//  ViewController.swift
//  Motion
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World")
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(gesture:)))
        view.addGestureRecognizer(gesture)
        
//        test
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let gpoint = sender.location(in: self.view)
        let myView = generateRandomView(gpoint: gpoint)
        myView.backgroundColor = generateRandomColor()
        view.addSubview(myView)
//        let dynamicAnimator = UIDynamicAnimator()
//        let gravityBehavior = UIGravityBehavior()
//        gravityBehavior.magnitude = 1000
//        dynamicAnimator.addBehavior(gravityBehavior)
//        gravityBehavior.addItem(myView)
//        gravityBehavior.removeItem(myView)

    }
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Began")
        case .changed:
            print("Change to \(gesture.location(in: view))")
        case .ended:
            print("Ended")
        case .failed, .cancelled:
            print("F or C")
        case .possible:
            print("Possible")
        }
    }
}


func generateRandomView(gpoint: CGPoint) -> UIView {
    let random = arc4random_uniform(2)
    if random == 0 {
        let square = UIView(frame: CGRect(x: gpoint.x, y: gpoint.y, width:100, height:100))
        return square
    } else {
        let circle = UIView(frame: CGRect(x: gpoint.x - 50, y: gpoint.y - 50, width: 100.0, height: 100.0))
        circle.layer.cornerRadius = 50
        circle.clipsToBounds = true
        return circle
    }
}

func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}

