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
        Person(name: "Jesus", description: "Crucification", date: Date()),
        Person(name: "Mickael Jackson", description: "Drogue", date: Date()),
        Person(name: "Albert Einstein", description: "Rupture d'anévrisme", date: Date()),
        Person(name: "Stephen Hawking", description: "Sclérose latérale amyotrophique", date: Date()),
    ]
}
