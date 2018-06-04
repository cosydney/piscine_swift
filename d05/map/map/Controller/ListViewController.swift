//
//  SecondViewController.swift
//  map
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var addresses : [Address] = [
        Address(name: "Ecole 42", address: "96 Boulevard Beissiéres, 75017, Paris"),
        Address(name: "Home", address: "59 rue des archives, 75003, Paris"),
        Address(name: "Annecy", address: "6 rue notre dame, 74000 , Annecy, France"),
        Address(name: "Val d'isére", address: "Val d'isére"),
        Address(name: "Apple", address: "Apple, Sacramento, California, US")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].name
        cell.detailTextLabel?.text = addresses[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        alert
//        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//        alertController.addAction(alertAction)
//        present(alertController, animated: true, completion: nil)
        print("switching index")
        self.tabBarController?.selectedIndex = 0

    }
    
    

}

