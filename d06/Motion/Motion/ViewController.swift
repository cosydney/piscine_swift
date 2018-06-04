//
//  ViewController.swift
//  Motion
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    private var dynamiqueAnimator : UIDynamicAnimator!
    private let gravityBehavior = UIGravityBehavior()
    
    private static let gravityScale = 2.5
    
    private let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World")
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(gesture:)))
        view.addGestureRecognizer(gesture)
        
//
        dynamiqueAnimator = UIDynamicAnimator(referenceView: self.view)
        
        dynamiqueAnimator.addBehavior(gravityBehavior)
        motionManager.accelerometerUpdateInterval = 0.2
        let queue = OperationQueue()
        motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler as! CMAccelerometerHandler)
    }
    
    func accelerometerHandler(data: CMAccelerometerData?, error : NSError?) {
        if error == nil && data != nil {            
            let gravityVector = CGVector(dx: CGFloat(data!.acceleration.x *
                ViewController.gravityScale),dy: CGFloat(-data!.acceleration.y * ViewController.gravityScale))
            gravityBehavior.gravityDirection = gravityVector
        }
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let gpoint = sender.location(in: self.view)
        let myView = generateRandomView(gpoint: gpoint)
        myView.backgroundColor = generateRandomColor()

        let dynamicAnimator = UIDynamicAnimator()
        let gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 1000
        dynamicAnimator.addBehavior(gravityBehavior)
        gravityBehavior.addItem(myView)
        gravityBehavior.removeItem(myView)
        view.addSubview(myView)
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
        let square = UIView(frame: CGRect(x: gpoint.x - 50, y: gpoint.y - 50, width:100, height:100))
        return square
    } else {
        let circle = UIView(frame: CGRect(x: gpoint.x - 50, y: gpoint.y - 50, width: 100.0, height: 100.0))
        circle.layer.cornerRadius = 50
        circle.clipsToBounds = true
        return circle
    }
}

func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}

