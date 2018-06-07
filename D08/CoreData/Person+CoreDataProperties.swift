//
//  Person+CoreDataProperties.swift
//  CoreData
//
//  Created by Sydney COHEN on 6/6/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: NSDecimalNumber?

}
