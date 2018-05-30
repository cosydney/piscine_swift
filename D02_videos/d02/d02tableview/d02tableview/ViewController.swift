//
//  ViewController.swift
//  d02tableview
//
//  Created by Sydney COHEN on 5/29/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView! {
        didSet {
            TableView.delegate = self
            TableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return Data.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell")
        cell?.textLabel?.text = Data.films[indexPath.row].0
        cell?.detailTextLabel?.text = String(Data.films[indexPath.row].1)
        return cell!
    }
    
    
}

