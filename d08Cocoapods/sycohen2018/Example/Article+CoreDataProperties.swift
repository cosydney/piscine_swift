//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Sydney COHEN on 6/7/18.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var langue: String?
    @NSManaged public var modificationDate: NSDate?
    @NSManaged public var titre: String?

}

