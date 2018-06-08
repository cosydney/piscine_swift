//
//  File.swift
//  sycohen2018
//
//  Created by Sydney COHEN on 6/7/18.
//

import UIKit
import CoreData
import Foundation

@objc(Article)
public class Article: NSManagedObject {
    
    @NSManaged public var titre:             String?
    @NSManaged public var content:           String?
    @NSManaged public var langue:            String?
    @NSManaged public var image:             NSData?
    @NSManaged public var dateCreation:      NSDate?
    @NSManaged public var dateModification:  NSDate?
    
    override public var description: String {
        return "Titre : \(titre)\ncontent : \(content)\nLangue : \(langue)\nDate de creation : \(dateCreation)"
    }
    
}




