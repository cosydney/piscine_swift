//
//  MessagesTableViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/3/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController, UITextFieldDelegate {


    var apiController: APIController?
    var topic: TopicReceiver?

    @IBOutlet weak var messageField: UITextField!
    var selectedMessage: MessageReception?
    var messages: [MessageReception]?
    var modified_messages : [MessageReception] = []
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.color = .black
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()


    @IBOutlet weak var indicatorView: UIView!

    func alter_messages(messages: [MessageReception]) -> [MessageReception] {
        modified_messages = messages
        var array : [MessageReception] = []
        var count : Int = 0
        for message in modified_messages {
            array.append(message)
            array[count].replies.insert(message, at:0)
            count+=1
        }
        return array
    }
    
    func reloadMessages() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
            self.activityIndicator.hidesWhenStopped = true;
            self.activityIndicator.startAnimating();
        }
        apiController?.topicMessages(topic: self.topic!) {
            d in
            print("reloadedMessages:")
            print(String(data: d, encoding: .utf8)!)
            
            let messagesArray: [MessageReception]? = decodeDataArray(data: d)
            guard let messages = messagesArray else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                    self.activityIndicator.stopAnimating();
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                return
            }
            self.messages = messages
            self.modified_messages = self.alter_messages(messages: messages)
            DispatchQueue.main.async {
                self.messageField.isHidden = false
                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                self.activityIndicator.stopAnimating();
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editMessageSegue") {
            if let editMessageVC = segue.destination as? EditMessageViewController {
                let message = sender as? MessageReception
                editMessageVC.apiController = self.apiController
                editMessageVC.message = message
                editMessageVC.topic = topic
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(messageField.text)
        ////////////// TODO Add text and reload page here//////////////////////
        guard let author_id = apiController?.author_id else {
            return true
        }
        guard let topic_id = topic?.id else {
            return true
        }
        
        let message = Message(
            author_id: String(author_id),
            content: messageField.text!,
            messageable_id: String(topic_id),
            messageable_type: "Topic")
        let messageHandler = MessageCreationHandler(id: String(topic_id), message: message)
        print(messageHandler)
        apiController?.createMessage(messageCreate: messageHandler) {
            d in
            print(String(data: d, encoding: .utf8)!)
            self.reloadMessages()
        }
        messageField.text = ""
        return true
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refreshing")
        reloadMessages()
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        self.refreshControl?.tintColor = UIColor.red
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        view.addSubview(activityIndicator)
        setupActivityIndicator()
        self.messageField.isHidden = true
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.startAnimating();
        setupAlerts()
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 270
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // linking text input
        messageField.delegate = self
        //      Keyboard dismissed
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.keyboardDismissMode = .interactive
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if apiController?.login != nil {
            reloadMessages()
        }
        else {
            apiController?.me() {
                _ in
                self.reloadMessages()
            }
        }
    }

    func setupActivityIndicator() {
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete your topic ?.", preferredStyle: UIAlertControllerStyle.alert)
    let editAlert = UIAlertController(title: "Edit", message: "Are you sure you want to edit your topic ?", preferredStyle: UIAlertControllerStyle.alert)
    let accessDenied = UIAlertController(title: "ACCESS DENIED", message: "You don't have the rights", preferredStyle: UIAlertControllerStyle.alert)

    func setupAlerts() {
        accessDenied.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (action: UIAlertAction!) in
            print("Access Denied!")
        }))

        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Delete request")                   //////PlaceHolder
            guard let message = self.selectedMessage else {
                print("no selected topic to delete!")
                return
            }
            self.apiController?.deleteMessage(message: message){
                _ in
                print("topic deleted")
                self.reloadMessages()
            }
        }))

        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

        editAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Edit Request")                   //////PlaceHolder
        }))

        editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

    }


    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let message = modified_messages[indexPath.section].replies[indexPath.row]!
        
        selectedMessage = message

        /////////////////////Edit Action
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            if self.apiController?.login! != message.author.login {           /////////PlaceHolder
                self.present(self.accessDenied, animated: true, completion:  nil)
            }
            else {
//                self.present(self.editAlert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "editMessageSegue", sender: message)
            }
        })
        editAction.backgroundColor = UIColor.blue

        ////////////////////Delete Action
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            if self.apiController?.login! != message.author.login {         /////////////////PlaceHolder
                self.present(self.accessDenied, animated: true, completion:  nil)
            }
            else {
                self.present(self.deleteAlert, animated: true, completion: nil)
            }
        })

        deleteAction.backgroundColor = UIColor.red
        return [editAction, deleteAction]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return modified_messages.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modified_messages[section].replies.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.text = messages![section].author.login
        label.textColor = UIColor.white
        label.frame = CGRect(x: 10, y: 5, width: 400, height: 20)
        view.addSubview(label)
        return view
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell", for: indexPath) as! MessageTableViewCell
        cell.author.text = modified_messages[indexPath.section].replies[indexPath.row]!.author.login
        cell.date.text = modified_messages[indexPath.section].replies[indexPath.row]!.created_at.forumTimeFormat
        if (indexPath.row != 0){
            cell.author.text = "-> " + cell.author.text!
        }
        cell.message.text = modified_messages[indexPath.section].replies[indexPath.row]!.content
        return cell
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
