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
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehaviour: UIDynamicItemBehavior!
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        itemBehaviour = UIDynamicItemBehavior(items: [])
        itemBehaviour.elasticity = 0.3
        animator.addBehavior(itemBehaviour)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewillappear")
        super.viewWillAppear(animated)
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startAccelerometerUpdates(to: queue, withHandler: accHandler)
        }
        else {
            print("accelerometer is not available")
        }
    }
    
    func accHandler(data: CMAccelerometerData?, error: Error?) {
        if let myData = data {
            let x = CGFloat(myData.acceleration.x);
            let y = CGFloat(myData.acceleration.y);
            let v = CGVector(dx: x, dy: -y);
            gravity.gravityDirection = v;
        }
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let gpoint = sender.location(in: self.view)
        let myView = Shape(point: gpoint,
                          maxwidth: self.view.bounds.width,
                          maxheight: self.view.bounds.height)
        
        view.addSubview(myView)
        gravity.addItem(myView)
        collision.addItem(myView)
        itemBehaviour.addItem(myView)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(gesture:)))
        myView.addGestureRecognizer(gesture)
        
        let press = UITapGestureRecognizer(target: self, action: #selector(self.handleLongPress(press:)))
        myView.addGestureRecognizer(press)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        myView.addGestureRecognizer(pinch)
        
        let rotate = UIRotationGestureRecognizer(target: self, action:#selector(self.handleRotate(rotate:)))
        myView.addGestureRecognizer(rotate)
    }
    
    @objc func handlePinch(recognizer : UIPinchGestureRecognizer) {
        print("handlePinch")
        if let view = recognizer.view {
            print(recognizer.scale)
            
            switch recognizer.state {
            case .began:
                print("PBegan")
                self.gravity.removeItem(view)
                self.collision.removeItem(view)
                self.itemBehaviour.removeItem(view)
                
            case.changed:
                print("PChanged")
                recognizer.view?.layer.bounds.size.height *= recognizer.scale
                recognizer.view?.layer.bounds.size.width *= recognizer.scale
                if let tmp = recognizer.view! as? Shape {
                    if (tmp.isCircle) {recognizer.view!.layer.cornerRadius *= recognizer.scale}}
                recognizer.scale = 1
                
            case .ended:
                print("PEnded")
                self.gravity.addItem(view)
                self.collision.addItem(view)
                self.itemBehaviour.addItem(view)
                
                
            case .failed, .cancelled:
                print("P F or C")
            case .possible:
                print("PPossible")
            }
        }
    }
    
    @objc func handleRotate(rotate: UIRotationGestureRecognizer){
        switch rotate.state {
        case .began:
            self.gravity.removeItem(rotate.view!)
        case .changed:
            rotate.view?.transform = view.transform.rotated(by: rotate.rotation)
            animator.updateItem(usingCurrentState: rotate.view!)
        case .ended:
            self.gravity.addItem(rotate.view!)
        case .failed, .cancelled:
            print("RF or C")
        default:
            break
        }
    }
    
    @objc func handleLongPress(press: UILongPressGestureRecognizer) {
        switch press.state {
        case .ended:
            print("ended")
            press.view?.backgroundColor = generateRandomColor()
        case .failed, .cancelled:
            print("F or C")
        default:
            break
        }
    }
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Began")
            self.gravity.removeItem(gesture.view!)
        case .changed:
            print("Change to \(gesture.location(in: view))")
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            animator.updateItem(usingCurrentState: gesture.view!)
        case .ended:
            print("Ended")
            self.gravity.addItem(gesture.view!)
        case .failed, .cancelled:
            print("F or C")
        case .possible:
            print("Possible")
        }
    }
}


func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}
