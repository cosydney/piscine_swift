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
    let articleManager = ArticleManager()
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var title = NSLocalizedString("title", comment: "description of the content")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        langue = Locale.current.languageCode!

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        articles = articleManager.getArticles(withLang: langue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        articles = articleManager.getArticles(withLang: langue)
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
        let currentArticle = articles![indexPath.row]
        cell.titre.text = currentArticle.titre
        if (currentArticle.creationDate != nil) {
            cell.creationDate.text = format_date(date: currentArticle.creationDate!)
            cell.modificationDate.text = format_date(date: currentArticle.modificationDate!)
        }

        if cell.creationDate.text == cell.modificationDate.text! {
            cell.modificationDate.isHidden = true
        }
        
        
        cell.photo.image = (currentArticle.image != nil) ? UIImage(data: currentArticle.image! as Data) : nil
        cell.descriptionLabel.text = currentArticle.content
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let evc = segue.destination as? AddViewController {
        if (segue.identifier == "addSegue" && sender != nil) {
                evc.edit = true
                evc.article = sender as? Article
                evc.articleManager = self.articleManager
            }
            if (segue.identifier == "addSegue") {
                evc.articleManager = self.articleManager
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED:",indexPath.row, articles![indexPath.row])
        performSegue(withIdentifier: "addSegue", sender: articles![indexPath.row])
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            articleManager.removeArticle(article: articles![indexPath.row])
            articleManager.save()
            articles?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
