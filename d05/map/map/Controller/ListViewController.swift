//
//  SecondViewController.swift
//  map
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import MapKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].title
        cell.detailTextLabel?.text = addresses[indexPath.row].locationName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapTab = self.tabBarController?.viewControllers![0] as! MapViewController
        mapTab.centerMapOnLocation(location: addresses[indexPath.row].location)
        self.tabBarController?.selectedIndex = 0
    }
}

