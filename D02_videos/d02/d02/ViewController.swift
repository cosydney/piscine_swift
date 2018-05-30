//
//  ViewController.swift
//  d02
//
//  Created by Sydney COHEN on 5/29/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segue1" {
//                print("segue1")
//                segue.destination
//        }
//    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print(unwindSegue.identifier)
    }
}

