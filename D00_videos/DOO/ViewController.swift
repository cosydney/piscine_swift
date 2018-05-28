//
//  ViewController.swift
//  DOO
//
//  Created by Sydney Cohen on 24/05/2018.
//  Copyright © 2018 Sydney Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hellolabel: UILabel!
    
    @IBAction func button(_ sender: UIButton) {
        if hellolabel.text == "Hello World !"{
            hellolabel.text = "Hello"
        }
        else {
            hellolabel.text = "Hello World !"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

