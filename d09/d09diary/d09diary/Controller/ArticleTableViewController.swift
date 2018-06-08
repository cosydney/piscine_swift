//
//  ArticleTableViewController.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import sycohen2018

class ArticleTableViewController: UITableViewController {
    
    var articles: [Article]?
    var langue: String = "en"
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("controller did load")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        langue = Locale.current.languageCode!
        let articleManager = ArticleManager()


//        let deuse = articleManager.newArticle()
//        deuse.titre = "Article 2"
//        deuse.content = "Mon deuxieme article apres le premier article in English language"
//        deuse.creationDate = NSDate()
//        deuse.modificationDate = NSDate()
//        deuse.langue = "en"
//        articleManager.save()
//
//        print("LANGUE", langue)

//        let prems = articleManager.newArticle()
//        prems.titre = "Article 1"
//        prems.content = "Mon premier article du d08 trololo"
//        prems.creationDate = NSDate()
//        prems.modificationDate = NSDate()
//        prems.langue = "fr"
//        articleManager.save()
//        print(articleManager.getAllArticles())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        articles = articleManager.getArticles(withLang: langue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading here")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (articles?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        if (articles?[indexPath.row] != nil) {
        cell.titre.text = articles![indexPath.row].titre
        cell.creationDate.text = format_date(date: articles![indexPath.row].creationDate!)
            cell.photo.image = (articles![indexPath.row].image != nil) ? UIImage(data: articles![indexPath.row].image! as Data) : nil
        cell.modificationDate.text = format_date(date: articles![indexPath.row].modificationDate!)
        cell.descriptionLabel.text = articles![indexPath.row].content
            
            
        }
        
        return cell
    }
    
    func format_date(date: NSDate) -> String  {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date as Date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return (myStringafd)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
