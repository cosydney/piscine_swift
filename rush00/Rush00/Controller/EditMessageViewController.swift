//
//  EditMessageViewController.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/3/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class EditMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputField: UITextView!
    
    var message : MessageReception?
    var topic: TopicReceiver?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func doneButton(_ sender: Any) {
        //////////////////// TODO add call to api controller here////////////////////////////////
        message?.content = inputField.text
        guard let author_id = apiController?.author_id else {
            return
        }
        guard let topic_id = topic?.id else {
            return
        }
        guard let message_id = message?.id else {
            return
        }
        let updatedMessage = Message(
            author_id: String(author_id),
            content: (self.message?.content)!,
            messageable_id: String(topic_id),
            messageable_type: "Topic")
        let messageCreationHandler = MessageCreationHandler(id: String(message_id), message: updatedMessage)
        apiController?.updateMessage(message: messageCreationHandler) {
            d in
            print("result", String(data: d, encoding: .utf8)!)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    var apiController: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        self.inputField.text = message?.content
//        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(createTopic))
        navigationItem.rightBarButtonItem = doneButton
        doneButton!.isEnabled = false
        setupTextFields()
        // Do any additional setup after loading the view.
    }
    
    func setupTextFields() {
        self.inputField.textInputView.clipsToBounds = true
        self.inputField.textInputView.layer.shadowColor = UIColor.black.cgColor
        self.inputField.textInputView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.inputField.textInputView.layer.shadowOpacity = 0.3
        self.inputField.textInputView.layer.shadowRadius = 3.0
        self.inputField.textInputView.layer.borderWidth = 1
        self.inputField.textInputView.layer.cornerRadius = 5.0
        self.inputField.textInputView.layer.borderColor = UIColor.black.cgColor
        self.inputField.delegate = self
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        if (inputField.text != ""){
            doneButton!.isEnabled = true
        }
        else {
            doneButton!.isEnabled = false
        }
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
