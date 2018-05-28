//
//  ViewController.swift
//  ex01
//
//  Created by Sydney COHEN on 5/28/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewddload")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var hellolabel: UILabel!
    @IBAction func clickbutton(_ sender: UIButton) {
        if hellolabel.text == "Hello World !"{
            hellolabel.text = "Hello"
        }
        else {
            hellolabel.text = "Hello World !"
        }
    }
    

}

