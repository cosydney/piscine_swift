//
//  ViewController.swift
//  Rush00
//
//  Created by Jean-christophe BLONDEAU on 6/2/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit
import WebKit

func randomString(length: Int) -> String {

    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)

    var randomString = ""

    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }

    return randomString
}

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let state = randomString(length: 64)
        let queryItems = [
            NSURLQueryItem(name: "client_id", value: "c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed"),
            NSURLQueryItem(name: "redirect_uri", value: "https://127.0.0.1"),
            NSURLQueryItem(name: "scope", value: "public forum"),
            NSURLQueryItem(name: "state", value: state),
            NSURLQueryItem(name: "response_type", value: "code"),
        ]
        let urlComps = NSURLComponents(string: "https://api.intra.42.fr/oauth/authorize")!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let url = urlComps.url!
        print(url)
        
        let accessRequest = NSMutableURLRequest(url: url)
        accessRequest.httpMethod = "POST"
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(accessRequest as URLRequest)
        
        
        
        
        
        
//        self.authUser(login: "jblondea", password: PasswordHolder.password) {
//            state, code in
//
//            self.authApp(code: code, state: state) {
//                dic in
//                
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login_segue" {
            if let destinationVC = segue.destination as? TopicsViewController {
                let token = sender as? String
                destinationVC.token = token
                print("prepared")
            }
        }
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation: WKNavigation!) {
        guard let url = URLComponents(string: (webView.url?.absoluteString)!) else { return }
        guard let code = url.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        guard let state = url.queryItems?.first(where: { $0.name == "state" })?.value else { return }
        print(code)
        print(state)
        self.authApp(code: code, state: state) {
            dic in
            print(dic)
            let token = dic.value(forKey: "access_token")
            print("token is : \(token!)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "login_segue", sender: token)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func authApp(code: String, state: String, completionHandler: @escaping (NSDictionary) -> Void) {
        let queryItems = [
            NSURLQueryItem(name: "grant_type", value: "authorization_code"),
            NSURLQueryItem(name: "client_id", value: "c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed"),
            NSURLQueryItem(name: "client_secret", value: "0b834b0534ae6f5bccd77e04c202c8d7230b16b2ad057076ab28911d3833e907"),
            NSURLQueryItem(name: "code", value: code),
            NSURLQueryItem(name: "redirect_uri", value: "https://127.0.0.1"),
            NSURLQueryItem(name: "state", value: state),
        ]
        let urlComps = NSURLComponents(string: "https://api.intra.42.fr/oauth/token")!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let url = urlComps.url!
        
        let accessRequest = NSMutableURLRequest(url: url)
        accessRequest.httpMethod = "POST"

        let task  = URLSession.shared.dataTask(with: accessRequest as URLRequest) {
            (data: Data?, urlResponse: URLResponse?, error: Error?) in
            if let err = error {
                print(err)
                return
            }
            if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        completionHandler(dic)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func authUser(login: String, password: String, completionHandler: @escaping (_ state: String, _ code: String) -> Void) {
        let state = randomString(length: 64)
        let queryItems = [
            NSURLQueryItem(name: "client_id", value: "c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed"),
            NSURLQueryItem(name: "redirect_uri", value: "https://127.0.0.1"),
            NSURLQueryItem(name: "scope", value: "forum"),
            NSURLQueryItem(name: "state", value: state),
            NSURLQueryItem(name: "response_type", value: "code"),
        ]
        let urlComps = NSURLComponents(string: "https://api.intra.42.fr/oauth/authorize")!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let url = urlComps.url!
        print(url)
        
        var accessRequest = NSMutableURLRequest(url: url)
        accessRequest.httpMethod = "GET"
//        accessRequest.setValue("Bearer " + token! , forHTTPHeaderField: "Authorization")
        let task  = URLSession.shared.dataTask(with: accessRequest as URLRequest) {
            (data: Data?, urlResponse: URLResponse?, error: Error?) in
            if let err = error {
                print(err)
                return
            }
            if let d = data {
                do {
//                    completionHandler(state, String(data: d, encoding: .utf8)!)
                    print("login page")
                    self.logUser(login: login, password: password, state: state, content: String(data: d, encoding: .utf8)!, completionHandler: completionHandler)
                    
//                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                        completionHandler(dic)
//                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func logUser(login: String, password: String, state: String, content: String, completionHandler: @escaping (_ state: String, _ code: String) -> Void) {
        print(content)
        var csrf = ""
        do {
            let regex = try NSRegularExpression(pattern: "<input type=\"hidden\" name=\"authenticity_token\" value=\"(.*)\" />")
            let results = regex.matches(in: content, range: NSRange(content.startIndex..., in: content))
            print(results)
            for res in results {
                let range = res.range(at: 1)
                csrf = String(content[Range(range, in: content)!])
            }
//            let res = results.map {
//                String(content[Range($0.range, in: content)!])
//            }
//            print(res)
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }
        print(csrf)
        
        let state = randomString(length: 64)
        let queryItems = [
            NSURLQueryItem(name: "utf8", value: "&#x2713;"),
            NSURLQueryItem(name: "authenticity_token", value: csrf),
            NSURLQueryItem(name: "user[login]", value: login),
            NSURLQueryItem(name: "user[password]", value: password),
            NSURLQueryItem(name: "commit", value: "Sign in"),
        ]
        let urlComps = NSURLComponents(string: "https://signin.intra.42.fr/users/sign_in")!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let url = urlComps.url!
        print(url)
        
        var accessRequest = NSMutableURLRequest(url: url)
        accessRequest.httpMethod = "POST"
        //        accessRequest.setValue("Bearer " + token! , forHTTPHeaderField: "Authorization")
        let task  = URLSession.shared.dataTask(with: accessRequest as URLRequest) {
            (data: Data?, urlResponse: URLResponse?, error: Error?) in
            print(urlResponse)
            if let err = error {
                print(err)
                return
            }
            if let d = data {
                do {
                    print(String(data: d, encoding: .utf8)!)
                    //                    completionHandler(state, String(data: d, encoding: .utf8)!)
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
}

