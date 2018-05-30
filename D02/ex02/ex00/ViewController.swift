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
//                didSet {
//                    personTableview.delegate = self
//                    personTableview.dataSource = self
//                }

//    }
    

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell")
        cell?.textLabel?.text = persons[indexPath.row].0
        cell?.detailTextLabel?.text = String(persons[indexPath.row].1)
        return cell!
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        print("HELO", segue.identifier)
        print(segue)
        self.personTableView.reloadData()
    }

}

