//
//  ViewController.swift
//  sycohen2018
//
//  Created by cosydney on 06/07/2018.
//  Copyright (c) 2018 cosydney. All rights reserved.
//

import UIKit
import sycohen2018

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load from controller")
        let articleManager = ArticleManager()
        
        let prems = articleManager.newArticle()
        prems.titre = "Article 1"
        prems.content = "Mon premier article du d08"
        prems.creationDate = Date()
        prems.modificationDate = Date()
        prems.langue = "fr"
        articleManager.save()
        
        let deuse = articleManager.newArticle()
        deuse.titre = "Article 2"
        deuse.content = "Mon deuxieme article apres le premier article"
        deuse.creationDate = Date()
        deuse.modificationDate = Date()
        deuse.langue = "en"
        articleManager.save()
        
        print(articleManager.getAllArticles())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

