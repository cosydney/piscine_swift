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
        Person(name: "General John Sedgwick", description: "General John Sedgwick was killed by a sniper in the American Civil War shortly after uttering the words \"They couldn't hit an elephant at this distance.\" (Contrary to popular belief, though, they weren't his last words. They were his second-last. His last words were agreeing that dodging was in fact a good idea.)", date: Date()),
        Person(name: "Jesus", description: "Crucification", date: Date()),
        Person(name: "Mickael Jackson", description: "Drogue", date: Date()),
        Person(name: "Albert Einstein", description: "Rupture d'anévrisme", date: Date()),
        Person(name: "Stephen Hawking", description: "Sclérose latérale amyotrophique", date: Date()),
    ]
}
