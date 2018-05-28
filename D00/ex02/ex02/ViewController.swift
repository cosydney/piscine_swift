//
//  ViewController.swift
//  ex02
//
//  Created by Sydney COHEN on 5/28/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var results: UILabel!
    @IBAction func one(_ sender: UIButton) {
        results.text = "1"
        print("1")
    }
    @IBAction func two(_ sender: UIButton) {
        results.text = "2"
        print("2")
    }
    @IBAction func three(_ sender: Any) {
        results.text = "3"
        print("3")
    }
    @IBAction func four(_ sender: UIButton) {
        results.text = "4"
        print("4")
    }
    @IBAction func five(_ sender: UIButton) {
        results.text = "5"
        print("5")
    }
    @IBAction func six(_ sender: UIButton) {
        results.text = "6"
        print("6")
    }
    @IBAction func seven(_ sender: UIButton) {
        results.text = "7"
        print("7")
    }
    @IBAction func eight(_ sender: Any) {
        results.text = "8"
        print("8")
    }
    @IBAction func nine(_ sender: UIButton) {
        results.text = "9"
        print("9")
    }
    @IBAction func zero(_ sender: UIButton) {
        results.text = "0"
        print("0")
    }
    @IBAction func AC(_ sender: UIButton) {
        print("AC")
    }
    @IBAction func neg(_ sender: UIButton) {
        print("NEG")
    }
    @IBAction func plus(_ sender: UIButton) {
        print("plus")
    }
    @IBAction func multiply(_ sender: UIButton) {
        print("*")
    }
    @IBAction func minus(_ sender: UIButton) {
        print("-")
    }
    @IBAction func divide(_ sender: UIButton) {
        print("/")
    }
    @IBAction func equal(_ sender: UIButton) {
        print("=")
    }
}
