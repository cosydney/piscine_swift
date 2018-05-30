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

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell")
        cell?.textLabel?.text = persons[indexPath.row].name
        cell?.detailTextLabel?.text = String(persons[indexPath.row].description)
        return cell!
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        self.personTableView.reloadData()
    }

}

