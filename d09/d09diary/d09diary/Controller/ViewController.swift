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
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(succes, error) in
                    if succes {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
                    })
        }
        else {
            showAlertController("Touch ID not available")
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
//        print("View did load from controllerdede")
//        let articleManager = ArticleManager()
//
//        let prems = articleManager.newArticle()
//        prems.titre = "Article 1"
//        prems.content = "Mon premier article du d08"
//        prems.creationDate = NSDate()
//        prems.modificationDate = NSDate()
//        prems.langue = "fr"
//        articleManager.save()
//
//        let deuse = articleManager.newArticle()
//        deuse.titre = "Article 2"
//        deuse.content = "Mon deuxieme article apres le premier article"
//        deuse.creationDate = NSDate()
//        deuse.modificationDate = NSDate()
//        deuse.langue = "en"
//        articleManager.save()
//
//        print(articleManager.getAllArticles())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

