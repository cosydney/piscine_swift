//
//  AddViewController.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import sycohen2018

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    let articleManager = ArticleManager()
    var articleManager: ArticleManager?
    var doneButton: UIBarButtonItem?
    let pickerController = UIImagePickerController()
    var edit: Bool = false
    var article: Article?

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titreInput: UITextField!
    @IBOutlet weak var contentInput: UITextView!
    
    @IBAction func pickImage(_ sender: UIButton) {
        showPickerLibrary()
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        showPickerCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItem = doneButton
        doneButton!.isEnabled = false
        titreInput.addTarget(self, action: #selector(editingHasStarted), for: .editingChanged)
        if (edit) {
            self.setfields()
            doneButton!.isEnabled = true
        }
        // Do any additional setup after loading the view.
    }

    func setfields() {
        print("setting up fields")
        titreInput.text = article?.titre
        contentInput.text = article?.content
        if let image = article?.image {
            imageView.image = UIImage(data: image as Data)
        }
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
        if (edit) {
            article?.modificationDate = NSDate()
            article?.titre = titreInput.text
            article?.content = contentInput.text
            if imageView.image != nil {
                if let imageData = UIImageJPEGRepresentation(imageView.image!, 1) {
                    article?.image = imageData as NSData?
                } else {
                    print("saveArticle : error")
                }
            }
            article?.modificationDate = NSDate()
            article?.langue = Locale.current.languageCode!
        } else {
            let newarticle = articleManager!.newArticle()
            newarticle.creationDate = NSDate()
            newarticle.modificationDate = NSDate()
            newarticle.titre = titreInput.text
            newarticle.content = contentInput.text
            if imageView.image != nil {
                if let imageData = UIImageJPEGRepresentation(imageView.image!, 1) {
                    newarticle.image = imageData as NSData?
                } else {
                    print("saveArticle : error")
                }
            }
            newarticle.modificationDate = NSDate()
            newarticle.langue = Locale.current.languageCode!
        }
        articleManager!.save()
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showPickerLibrary() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "No Library available", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showPickerCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "No Camera available", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController didFinishPickingMediaWithInfo")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
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
