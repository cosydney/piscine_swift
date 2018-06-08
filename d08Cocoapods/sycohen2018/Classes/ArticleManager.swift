//
//  ArticleManager.swift
//  sycohen2018
//
//  Created by Sydney COHEN on 6/7/18.
//

import Foundation
import CoreData


public class ArticleManager {
    
    private let context: NSManagedObjectContext = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentsDirectory = urls.last!
        let podBundle = Bundle(for: ArticleManager.self)
        let modelURL = podBundle.url(forResource: "sycohen2018", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        let url = applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    public init() {}
    
    public func save() {
        try! context.save()
    }
    
    public func newArticle() -> Article {
        var article : Article!
        context.performAndWait {
            let ent = NSEntityDescription.entity(forEntityName: "Article", in: self.context)!
            article = Article(entity: ent, insertInto: self.context)
        }
        return article
    }
    
    public func getAllArticles() -> [Article] {
        var articles : [Article]!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Article]
        }
        return articles.sorted(by: {$0.creationDate!.compare($1.creationDate!) == ComparisonResult.orderedDescending})
    }
    
    public func getArticles(withLang lang: String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "lang == %@", lang)
        var articles : [Article]!
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Article]
        }
        return articles.sorted(by: {$0.creationDate!.compare($1.creationDate!) == ComparisonResult.orderedDescending})
    }
    
    public func getArticles(containString str: String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "content contains[c] %@", str)
        var articles : [Article]!
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Article]
        }
        return articles.sorted(by: {$0.creationDate!.compare($1.creationDate!) == ComparisonResult.orderedDescending})
    }
    
    public func removeArticle(article: Article) {
        context.performAndWait{
            self.context.delete(article)
        }
    }
}








