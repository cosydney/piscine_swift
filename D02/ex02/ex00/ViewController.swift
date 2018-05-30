//
//  ViewController.swift
//  ex00
//
//  Created by Sydney COHEN on 5/30/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var persons = Data.peoples

    @IBOutlet weak var personTableView: UITableView!

//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        personTableView.estimatedRowHeight = 200
//        personTableView.rowHeight = UITableViewAutomaticDimension
//    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonTableViewCell
        cell.person = persons[indexPath.row]
        cell.setLabels()
        return cell
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        self.personTableView.reloadData()
    }

}

