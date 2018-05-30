//
//  AddNoteViewController.swift
//  ex00
//
//  Created by Sydney COHEN on 5/30/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var descriptionfield: UITextField!
    @IBOutlet weak var datefield: UIDatePicker!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if namefield.text! != "" {
            if segue.identifier == "backSegue" {
                if let vc = segue.destination as? ViewController {
                      vc.persons.append((namefield.text!, descriptionfield.text!, 2018))
                }
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "backSegue", sender: self)
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
