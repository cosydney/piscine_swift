//
//  ViewController.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import sycohen2018

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load from controllerdede")
        let articleManager = ArticleManager()
        
        let prems = articleManager.newArticle()
        prems.titre = "Article 1"
        prems.content = "Mon premier article du d08"
        prems.creationDate = NSDate()
        prems.modificationDate = NSDate()
        prems.langue = "fr"
        articleManager.save()

        let deuse = articleManager.newArticle()
        deuse.titre = "Article 2"
        deuse.content = "Mon deuxieme article apres le premier article"
        deuse.creationDate = NSDate()
        deuse.modificationDate = NSDate()
        deuse.langue = "en"
        articleManager.save()
        
        print(articleManager.getAllArticles())
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

