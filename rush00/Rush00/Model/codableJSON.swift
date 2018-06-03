//
//  codableJSON.swift
//  
//
//  Created by Raphael GHIRELLI on 6/2/18.
//

import Foundation

struct Author: Codable {
    let login: String
}

struct TopicReceiver: Codable {
    let id: Int
    var name: String
    var author: Author
    var created_at: String
    let updated_at: String
}

struct student: Codable {
    let id: Int
    let login: String
}

struct Tags: Codable {
    let name: String
}



struct TopicCreationHandler: Codable {
    var topic: TopicCreation
}

struct TopicCreation: Codable {
    let author_id: String
    let cursus_ids: [String]
    let kind: String
    let language_id: String
    let messages_attributes: [Message]
    let name: String
    let tag_ids: [String]
}

struct MessageCreationHandler: Codable {
    let id: String   // topic_id
    let message: Message // struct message
}

struct Message: Codable {
    let author_id: String
    let content: String
    let messageable_id: String
    let messageable_type: String
}

struct MessageReception: Codable {
    var id: Int
    var author: Author
    var content: String
    var created_at: String
    var updated_at: String
    var replies: [MessageReception?]
}

//let messageObject = Message(author_id: "", content: "", messageable_id: "", messageable_type: "")
//let encodedData = try? JSONEncoder().encode(messageObject)

