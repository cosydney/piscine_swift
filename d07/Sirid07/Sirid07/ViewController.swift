//
//  ViewController.swift
//  Sirid07
//
//  Created by Sydney COHEN on 6/6/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var response: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func makeRequestButton(_ sender: UIButton) {
      self.performAction()
    }
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "3cf2226232c8565ee76cbbfe1e2be493")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.bot = RecastAIClient(token : "ab4e43dca4143e9b24c2e76d99fc1cf1", language: "en")
        client.language = .english
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() 
        self.performAction()
        return true
    }
    
    func performAction() {
        print (textField.text as Any)
        if (textField.text != nil) {
            self.makeRequest(request: textField.text!)
        }
    }
    
    func makeRequest(request: String)
    {
        //Call makeRequest with string parameter to make a text request
        self.bot?.textRequest(request, successHandler: { (response) in
//            print("response", response)
//            print("intent", response.intents as Any)
            let location = response.get(entity: "location")
            let lat = location!["lat"]?.doubleValue
            let lng = location!["lng"]?.doubleValue
            print("lat", lat as Any, "lng", lng as Any)
            self.makeWeatherRequest(lat: lat!, lng: lng!)
        }, failureHandle: { (error) in
            print("error", error)
            self.response.text = "Error with Recast call"
        })
    }
    
    func makeWeatherRequest(lat: Double, lng: Double) {
        client.getForecast(latitude: lat, longitude: lng) { result in
        switch result {
        case .success(let currentForecast, let _):
            let summary = currentForecast.currently?.summary
            print("summary", summary as Any)
            DispatchQueue.main.async {
                self.response.text = summary
            }
            //  We got the current forecast!
            case .failure(let error):
                print("error", error)
            DispatchQueue.main.async {
                    self.response.text = "Error with Weather API"
            }
            //  Uh-oh. We have an error!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
