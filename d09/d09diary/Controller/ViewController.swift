//
//  ViewController.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
//import sycohen2018
import LocalAuthentication


class ViewController: UIViewController {
    
    @IBAction func loginTouchId(_ sender: UIButton) {
        authWithTouchID()
    }
    
    func authWithTouchID() {

        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply:
                {(succes, error) in
                    if succes {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }
                    else {
//                        self.showAlertController("Touch ID Authentication Failed")
//                        authenticateUser()
                    }
                    })
        }
        else {
//            authenticateUser()
        }
    }
    
    
    func authenticateUser() {
        let context = LAContext()
    
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Please authenticate to proceed.") { [weak self] (success, error) in
    
            guard success else {
                DispatchQueue.main.async {
                
                    // show something here to block the user from continuing
                }
            return
            }
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "loginSegue", sender: nil)
                // do something here to continue loading your app, e.g. call a delegate method
            }
        }
    }
    

    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authWithTouchID()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

