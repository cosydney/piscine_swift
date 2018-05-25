//
//  ViewController.swift
//  calculator
//
//  Created by Sydney Cohen on 24/05/2018.
//  Copyright © 2018 Sydney Cohen. All rights reserved.
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
    @IBOutlet weak var AC: UIButton!
    @IBOutlet weak var results: UILabel!
    @IBAction func AC(_ sender: UIButton) {
    }
    @IBAction func plusminus(_ sender: UIButton) {
    }
    @IBAction func percentage(_ sender: UIButton) {
    }
    @IBAction func divide(_ sender: UIButton) {
    }
    @IBAction func multiply(_ sender: UIButton) {
    }
    @IBAction func minus(_ sender: UIButton) {
    }
    @IBAction func plus(_ sender: Any) {
    }
    @IBAction func equal(_ sender: UIButton) {
    }
    @IBAction func zero(_ sender: UIButton) {
        results.text = "0"
    }
    @IBAction func one(_ sender: UIButton) {
        results.text = "1"
    }
    @IBAction func two(_ sender: UIButton) {
    }
    @IBAction func three(_ sender: UIButton) {
    }
    @IBAction func four(_ sender: UIButton) {
    }
    @IBAction func five(_ sender: UIButton) {
    }
    @IBAction func six(_ sender: UIButton) {
    }
    @IBAction func seven(_ sender: UIButton) {
    }
    @IBAction func eight(_ sender: UIButton) {
    }
    @IBAction func nine(_ sender: UIButton) {
    }

}

