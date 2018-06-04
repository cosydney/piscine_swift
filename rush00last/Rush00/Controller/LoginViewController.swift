//
//  LoginViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/2/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "webview_segue" {
//            let controller = segue.identifier as? ViewController
//        }
//    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "webview_segue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
