//
//  AddViewController.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import sycohen2018

class AddViewController: UIViewController {
    
    let articleManager = ArticleManager()
    var doneButton: UIBarButtonItem?
    
    @IBOutlet weak var titreInput: UITextField!
    @IBOutlet weak var contentInput: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItem = doneButton
        doneButton!.isEnabled = false
        titreInput.addTarget(self, action: #selector(editingHasStarted), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    func createArticle() {
  
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func editingHasStarted(){
        if (titreInput.text != nil && titreInput.text != ""){
            doneButton!.isEnabled = true
        } else {
            doneButton!.isEnabled = false
        }
    }
    
    @objc func doneAction() {
        print("creating article")
        let article = articleManager.newArticle()
        article.titre = titreInput.text
        article.content = contentInput.text
        article.creationDate = NSDate()
        article.langue = Locale.current.languageCode!
        article.modificationDate = NSDate()
        articleManager.save()
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
