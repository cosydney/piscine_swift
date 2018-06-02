//
//  TopicsViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/2/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {
    
    var token : String?
    
    @IBAction func logout(_ sender: UIButton) {
        performSegue(withIdentifier: "logout_segue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TOKEN", token!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
