//
//  MessagesTableViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/3/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    
    var apiController: APIController?
    var topic: TopicReceiver?

//    var messages: [MessageReception] = [
//        MessageReception(
//            id: 10, author: Author(login:"Sydney"), content: "Contenu blabla", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019",
//            replies: [
//                MessageReception(id: 10, author: Author(login:"Reply to Sydney"), content: "Super contenu", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019", replies: [nil]),
//                MessageReception(id: 10, author: Author(login: "Reply to Sydney 2nd"), content: "Contenu blabla 3", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019", replies: [nil]),
//                ]
//            ),
//        MessageReception(
//            id: 10, author: Author(login:"Jean Mi"), content: "Jean MI", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019",
//            replies: [
//                MessageReception(id: 10, author: Author(login:"Reply to Jean mi"), content: "Super contenu", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019", replies: [nil]),
//                MessageReception(id: 10, author: Author(login: "Reply to Jeanmi 2nd"), content: "Contenu blabla 3", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019", replies: [nil]),
//                MessageReception(id: 10, author: Author(login: "Reply to Jeanmi 2nd"), content: "Contenu blabla 3", created_at:"27 Janvier 2018", updated_at: "28 Fevrier 2019", replies: [nil]),
//                ]
//        )
//    ];
    
    var messages: [MessageReception]?
    var modified_messages : [MessageReception] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 270
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        print("loading messages..")
        apiController?.topicMessages(topic: self.topic!) {
            d in
//            print(String(data: d, encoding: .utf8)!)
            let messages: [MessageReception] = decodeDataArray(data: d)!
            print(messages)
            self.messages = messages
            self.modified_messages = self.alter_messages(messages: messages)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        modified_messages = self.alter_messages()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return modified_messages.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modified_messages[section].replies.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.text = messages![section].author.login
        label.frame = CGRect(x: 10, y: 5, width: 400, height: 20)
        view.addSubview(label)
        return view
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell", for: indexPath) as! MessageTableViewCell
//        indexPath.section
        cell.author.text = modified_messages[indexPath.section].replies[indexPath.row]!.author.login
        cell.date.text = modified_messages[indexPath.section].replies[indexPath.row]!.created_at.forumTimeFormat
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
