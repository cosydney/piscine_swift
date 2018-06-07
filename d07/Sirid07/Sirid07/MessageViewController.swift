//
//  MessageViewController.swift
//  Sirid07
//
//  Created by Sydney COHEN on 6/6/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import MessageKit
import ForecastIO
import RecastAI

class Message: MessageType {
        
    static var messageID: Int = 0
    var data: MessageData
    var sender: Sender

    var messageId: String {
        get {
            Message.messageID += 1
            return String(Message.messageID)
        }
    }
    
    var sentDate: Date = Date()
    init(text: String, sender: Sender) {
        data = MessageData.text(text)
        self.sender = sender
    }
}



class ConversationViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, MessageInputBarDelegate {
    
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "3cf2226232c8565ee76cbbfe1e2be493")

    override func viewDidAppear(_ animated: Bool) {
        self.bot = RecastAIClient(token : "ab4e43dca4143e9b24c2e76d99fc1cf1", language: "en")
        client.language = .french
    }
    
    let userSender = Sender(id: "user", displayName: "You")
    let botSender = Sender(id: "bot", displayName: "Weather Bot")
    var messages: [MessageType] = []
    
    func currentSender() -> Sender {
        return userSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 75
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
//        weatherService?.delegate = self
        messages.append(Message(text: "Bonjour maître, dans quelle ville puis-je vous donner la météo actuelle?", sender: botSender))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        print("send!")
        messages.append(Message(text: text, sender: userSender))
        print("msgs",text)
        
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
            inputBar.inputTextView.text = ""
        }
        
        self.makeRequest(request: text)
    }
    
    func makeRequest(request: String)
    {
        self.bot?.textRequest(request, successHandler: { (response) in
            let location = response.get(entity: "location")
            print("location", location)
            if (location != nil) {
                let lat = location!["lat"]?.doubleValue
                let lng = location!["lng"]?.doubleValue
                print("lat", lat as Any, "lng", lng as Any)
                if (lat != nil) {
                    self.makeWeatherRequest(lat: lat!, lng: lng!)
                } else {
                    self.messages.append(Message(text: "Petite erreur avec l'API Recast, peut tu re-essayer?", sender: self.botSender))
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                }
            } else {
                self.messages.append(Message(text: "Dans quelle ville souhaite tu avoir le temps?", sender: self.botSender))
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
            
        }, failureHandle: { (error) in
            print("error", error)
            self.messages.append(Message(text: "Recast semble pas tres content, peut tu reesayer?", sender: self.botSender))
        })
    }
    
    func makeWeatherRequest(lat: Double, lng: Double) {
        client.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, _):
                let summary = currentForecast.currently?.summary
                print("summary", summary as Any)
                DispatchQueue.main.async {
                    if (summary != nil){
                        self.messages.append(Message(text: "le temps est " + summary!.lowercased(), sender: self.botSender))
                    }
                    else {
                        self.messages.append(Message(text: "Dans quelle ville souhaite tu avoir le temps?", sender: self.botSender))
                    }
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                }
            case .failure(let error):
                print("error", error)
                DispatchQueue.main.async {
                    self.messages.append(Message(text: "Petite erreur avec l'api de meteo merci de reiterer.", sender: self.botSender))
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                }
            }
        }
    }
    
}
