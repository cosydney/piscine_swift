//
//  AddTopicViewController.swift
//  Rush00
//
//  Created by Raphael GHIRELLI on 6/3/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var topicName: UITextField!
    var doneButton: UIBarButtonItem?
    
    var apiController: APIController?
    var topic: TopicReceiver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItem = doneButton
        doneButton!.isEnabled = false
        setupTextFields()
        if let existingTopic = topic {
            topicName.text = existingTopic.name
            doneButton!.isEnabled = true
        }
       

    }
    
    func setupTextFields() {
        textView.clipsToBounds = true
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 3.0

        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5.0
        textView.isScrollEnabled = true
        textView.layer.borderColor = UIColor.black.cgColor
        
        
        topicName.placeholder = " Name"
        topicName.layer.borderWidth = 1
        topicName.layer.cornerRadius = CGFloat(Float(5.0))


        topicName.layer.shadowColor = UIColor.black.cgColor
        topicName.layer.shadowOffset = CGSize(width: 0  , height: 0)
        topicName.layer.shadowOpacity = 0.3
        topicName.layer.shadowRadius = 3.0
        topicName.clipsToBounds = true

        
        textView.delegate = self
        topicName.addTarget(self, action: #selector(editingHasStarted), for: .editingChanged)
        
        
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        editingHasStarted()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func editingHasStarted(){
        if (textView.text != "" && topicName.text != ""){
            doneButton!.isEnabled = true
        }
        else if (topic == nil) {
            doneButton!.isEnabled = false
        }
    }

    @objc func doneAction() {
        if var topicToUpdate = self.topic {
            topicToUpdate.name = topicName.text!
            updateTopic(topic: topicToUpdate)
        } else {
            createTopic()
        }
    }
    
    func createTopic() {
        //////////// TODO !!!! Topic Creation Request //////////////////////////
        guard let apiController = self.apiController else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        guard let author_id = apiController.author_id else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let message = Message(
            author_id: String(author_id),
            content: textView.text,
            messageable_id: "1",
            messageable_type: "Topic"
        )
        let topicCreation = TopicCreation(
            author_id: String(author_id),
            cursus_ids: ["1"],
            kind: "normal",
            language_id: "1",
            messages_attributes: [message],
            name: topicName.text!,
            tag_ids: ["5"]
        )
        let topicCreationHandler = TopicCreationHandler(topic: topicCreation)
        print("starting topic create request")
        
        doneButton?.isEnabled = false
        apiController.createTopic(topicCreate: topicCreationHandler) {
            d in
            //            print(String(data: d, encoding: .utf8)!)
            let topic: TopicReceiver = decodeData(data: d)!
            print(topic)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateTopic(topic: TopicReceiver) {
        doneButton?.isEnabled = false
        apiController?.updateTopic(topic: topic) {
            d in
            print(topic)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
