//
//  Article+CoreDataClass.swift
//  
//
//  Created by Sydney COHEN on 6/7/18.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {
    override public var description: String {
        return "Titre : \(titre)\ncontent : \(content)\nLangue : \(langue)\nDate de creation : \(dateCreation)"
    }
}



