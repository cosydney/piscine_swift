//
//  TopicsViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/2/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var apiController: APIController?
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.color = .black
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()

    @IBAction func addTopic(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addTopic", sender: nil)
    }
    @IBOutlet weak var tableview: UITableView!



    // var topics : [Topic]? = [
    //     Topic(id: 10, name: "Hello hello", author:Author(login:"rpirelli"), created_at: "27 Juin 2018",
    //           messages: [Message(author_id: "12", content: "Coucou c'est moi je suis un tres long message Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may Note that due to differences in intrinsic content size, cells with the same constraints (type) may", messageable_id: "34", messageable_type: "type"), Message(author_id: "12", content: "Coucou c'est lui", messageable_id: "34", messageable_type: "type")]
    //     ),
    //     Topic(id: 10, name: "YALA", author:Author(login:"sycohen"), created_at: "27 Juin 2018",
    //           messages: [Message(author_id: "12", content: "Lolololo", messageable_id: "34", messageable_type: "type"), Message(author_id: "12", content: "trololoi", messageable_id: "34", messageable_type: "type")]
    //     ),
    //     ]

    var topics: [TopicReceiver]?
    var selectedTopic: TopicReceiver?

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red

        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refreshing")
        reloadTopics()
        refreshControl.endRefreshing()
    }

    @IBAction func logout(_ sender: UIButton) {
        performSegue(withIdentifier: "unwind_to_login_segue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "messages_segue") {
            if let vc = segue.destination as? MessagesTableViewController {
                let indexPath = self.tableview.indexPathForSelectedRow!
                vc.title = topics![indexPath.row].name;
                vc.topic = topics![indexPath.row]
                vc.apiController = self.apiController
                // Setting messages variable here
//                vc.Messages = topics![indexPath.row].messages
            }
        }
        else if (segue.identifier == "addTopic") {
            if let addTopicVC = segue.destination as? AddTopicViewController {
                addTopicVC.apiController = self.apiController
            }
        }
        else if (segue.identifier == "updateTopic") {
            if let updateTopicVC = segue.destination as? AddTopicViewController {
//                let indexPath = self.tableview.indexPathForSelectedRow!
                let topic = sender as? TopicReceiver
                updateTopicVC.apiController = self.apiController
                updateTopicVC.topic = topic
            }
        }
    }


    func reloadTopics() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
            self.activityIndicator.hidesWhenStopped = true;
            self.activityIndicator.startAnimating();
        }
        apiController?.topics(sort: "-updated_at") {
            d in
            let topics: [TopicReceiver]? = decodeData(data: d)
            self.topics = topics
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
//                self.indicatorView.removeFromSuperview()
                self.activityIndicator.stopAnimating();
                self.tableview.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
     
        
        setupActivityIndicator()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
//        activityindicator.hidesWhenStopped = true;
//        activityindicator.startAnimating();
        self.tableview.estimatedRowHeight = 270
        self.tableview.rowHeight = UITableViewAutomaticDimension
        setupAlerts()
        self.tableview.addSubview(self.refreshControl)
        // Do any additional setup after loading the view.

//        apiController?.me() {
//            _ in
//            self.reloadTopics()
//        }

//        apiController?.topics(sort: "-updated_at") {
//            d in
//            let topics: [TopicReceiver]? = decodeData(data: d)
//            self.topics = topics
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
//        }

        // Topic creation
//        let message = Message(
//            author_id: "14834",
//            content: "Hello",
//            messageable_id: "1",
//            messageable_type: "Topic"
//        )
//        let topicCreation = TopicCreation(
//            author_id: "14834",
//            cursus_ids: ["1"],
//            kind: "normal",
//            language_id: "1",
//            messages_attributes: [message],
//            name: "test create",
//            tag_ids: ["632", "132", "5"]
//        )
//        let topicCreationHandler = TopicCreationHandler(topic: topicCreation)
//        print("starting topic create request")
//
//        apiController?.createTopic(topicCreate: topicCreationHandler) {
//            d in
//            print(String(data: d, encoding: .utf8)!)
//            var topic: TopicReceiver = decodeData(data: d)!
//            print(topic)
//            topic.name = "test 2"
//            self.apiController?.updateTopic(topic: topic) {
//                d in
//                print(String(data: d, encoding: .utf8)!)
//                self.apiController?.deleteTopic(topicId: String(topic.id)) {
//                    d in
//                    print(String(data: d, encoding: .utf8)!)
//                }
//            }
//        }

        // Troll request
//        let message = Message(
//            author_id: "14587",
//            content: "J'attends qu'ils partent aux toilettes, je me glisse doucement derrière leur mac... Et j'aime ça.",
//            messageable_id: "1",
//            messageable_type: "Topic"
//        )
//        let topicCreation = TopicCreation(
//            author_id: "14834",
//            cursus_ids: ["1"],
//            kind: "normal",
//            language_id: "1",
//            messages_attributes: [message],
//            name: "Je plug ma prise jack dans le mac des autres",
//            tag_ids: ["632", "132", "5"]
//        )
//        let topicCreationHandler = TopicCreationHandler(topic: topicCreation)
//        print("starting topic create request")
//
//        apiController?.createTopic(topicCreate: topicCreationHandler) {
//            d in
//            print(String(data: d, encoding: .utf8)!)
//            var topic: TopicReceiver = decodeData(data: d)!
//            print(topic)
////            topic.name = "test 2"
//            self.apiController?.updateTopic(topic: topic, author_id: "14587") {
//                d in
//                print(String(data: d, encoding: .utf8)!)
////                self.apiController?.deleteTopic(topicId: String(topic.id)) {
////                    d in
////                    print(String(data: d, encoding: .utf8)!)
////                }
//            }
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true);
        if apiController?.login != nil {
            reloadTopics()
        }
        else {
            apiController?.me() {
                _ in
                self.reloadTopics()
            }
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//             print("hellofewfew")
//            // remove the item from the data model
//            topics!.remove(at: indexPath.row)
//
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//            print("hello")
//            // Not used in our example, but if you were adding a new row, this is where you would do it.
//        }
//    }
    let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete your topic ?.", preferredStyle: UIAlertControllerStyle.alert)
    let editAlert = UIAlertController(title: "Edit", message: "Are you sure you want to edit your topic ?", preferredStyle: UIAlertControllerStyle.alert)
    let accessDenied = UIAlertController(title: "ACCESS DENIED", message: "You don't have the rights", preferredStyle: UIAlertControllerStyle.alert)

    func setupAlerts() {
        accessDenied.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (action: UIAlertAction!) in
            print("Access Denied!")
        }))

        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Delete request")                   //////PlaceHolder
            guard let topic = self.selectedTopic else {
                print("no selected topic to delete!")
                return
            }
            self.apiController?.deleteTopic(topic: topic){
                _ in
                print("topic deleted")
                self.reloadTopics()
            }
        }))

        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

        editAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // never used
            print("Edit Request")                   //////PlaceHolder
        }))

        editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let topic = topics![indexPath.row]
        selectedTopic = topic

        /////////////////////Edit Action
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            if self.apiController?.login! != topic.author.login{           /////////PlaceHolder
                self.present(self.accessDenied, animated: true, completion:  nil)
            }
            else {
                print(topic)
                self.performSegue(withIdentifier: "updateTopic", sender: topic)
            }
        })
        editAction.backgroundColor = UIColor.blue

        ////////////////////Delete Action
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            if self.apiController?.login! != topic.author.login {         /////////////////PlaceHolder
                self.present(self.accessDenied, animated: true, completion:  nil)
            }
            else {
                self.present(self.deleteAlert, animated: true, completion: nil)
            }
        })
        deleteAction.backgroundColor = UIColor.red
        return [editAction, deleteAction]
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        if let t = topics {
            return topics!.count
        }
        return 0
    }

//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let cell = tableview.dequeueReusableCell(withIdentifier: "topics_cell") as! TopicsTableViewCell
//
//        if "clanier" != cell.author.text {
//            print("Hello")
//            return nil
//
//        }
//        return indexPath
//    }



//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "topics_cell") as! TopicsTableViewCell
        cell.tag = indexPath.row
        cell.author.text = topics![indexPath.row].author.login
        cell.date.text = topics![indexPath.row].created_at.forumTimeFormat
        cell.title.text = topics![indexPath.row].name

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableCell = tableview?.cellForRow(at: indexPath) as! TopicsTableViewCell
        if (tableCell.author != nil) {
            performSegue(withIdentifier: "messages_segue", sender: indexPath.row);
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
