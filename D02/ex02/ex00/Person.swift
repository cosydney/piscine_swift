//
//  Person.swift
//  ex00
//
//  Created by Sydney COHEN on 5/30/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import Foundation

class Person {
    var name: String
    var description: String
    var date : Date
    
    init(name: String, description: String, date: Date)
    {
        self.name = name
        self.description = description
        self.date = date
    }
}

struct Data {
    static let peoples : [Person] = [
        Person(name: "Test", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", date: Date()),
        Person(name: "Jesus", description: "Crucification", date: Date()),
        Person(name: "Mickael Jackson", description: "Drogue", date: Date()),
        Person(name: "Albert Einstein", description: "Rupture d'anévrisme", date: Date()),
        Person(name: "Stephen Hawking", description: "Sclérose latérale amyotrophique", date: Date()),
    ]
}
