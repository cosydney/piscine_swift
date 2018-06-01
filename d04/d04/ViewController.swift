//
//  ViewController.swift
//  d04
//
//  Created by Sydney COHEN on 6/1/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    func receiveTweets(tweets: [Tweet]) {
        self.tweets = tweets
        tweetTableView.reloadData()
    }
    
    func errorTweets(error: NSError) {
        print(error)
    }
    
    @IBOutlet weak var tweetTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var tweets: [Tweet] = []
    var token: String = ""
    let query:String = "&src=typd&lang=fr&count=100&result_type=recent"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.text = "Ecole 42"
        tweetTableView.dataSource = self
        self.tweetTableView.rowHeight = UITableViewAutomaticDimension
        self.tweetTableView.estimatedRowHeight = 270
        
        let CUSTOMER_KEY = "OjHFXl9MDC8HiCun2h2RXcAkB"
        let CUSTOMER_SECRET = "n3c5XtLPTTQeqEEt4jocIVEmwn14hQTDTn18T6oWucmO5sn77q"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()
        
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;CHARSET=UTF-8", forHTTPHeaderField: "Content-type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let d = data
            do {
                if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d!) as? NSDictionary {
                    for (key, value) in dic {
                        if key as! String == "access_token" {
                            self.token = value as! String
                        }
                    }
                    let controller = APIController(delegate: self, token: self.token)
                    controller.get_tweet(search: "q=" + "ecole 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + self.query)
                }
            } catch (let err){
                print(err)
                return
            }
        }
        task.resume()
        
        self.tweetTableView.rowHeight = UITableViewAutomaticDimension
        self.tweetTableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count \(tweets.count)")
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath) as! TableViewCell
        
        cell.sizeToFit()
        cell.layoutIfNeeded()
        
        cell.name.text = tweets[indexPath.row].name
        cell.date.text = tweets[indexPath.row].date
        cell.desc.text = tweets[indexPath.row].text
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            tweets = []
            let controller = APIController(delegate: self, token: token)
            controller.get_tweet(search: "q=" + searchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + query)
        }
    }
    
    
    


}

