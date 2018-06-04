//
//  main.swift
//  
//
//  Created by Raphael GHIRELLI on 6/1/18.
//

import Foundation




var urlAccess = NSURL(string: "https://api.intra.42.fr/oauth/token")
var accessRequest = NSMutableURLRequest(url: urlAccess! as URL)
let CLIENT_ID = "c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed"
let SECRET_ID = "0b834b0534ae6f5bccd77e04c202c8d7230b16b2ad057076ab28911d3833e907"
let BEARER = ((CLIENT_ID + ":" + SECRET_ID).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))


func setupAccessRequest() {
    accessRequest.httpMethod = "POST"
    accessRequest.setValue("Basic " + BEARER , forHTTPHeaderField: "Authorization")
    accessRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
    accessRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//    accessRequest.httpBody = "&client_id=c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed".data(using: String.Encoding.utf8)
//    accessRequest.httpBody = "&client_secret=0b834b0534ae6f5bccd77e04c202c8d7230b16b2ad057076ab28911d3833e907".data(using: String.Encoding.utf8)
}



func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?) {
    print("hello")
    if let err = error {
        print(err)
        return
    }
    if let d = data {
        do {
            print(d)
            if let dic = String(data: d, encoding: .utf8) {
                print(dic)
            }
          
//            try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:String] {
//                            token = dic.value(forKey: "access_token") as? String
//                            delegate?.setToken(token!)
//                            print(dic)
//                        }
        }
        catch (let err) {
            print(err)
        }
    }
}







setupAccessRequest()
var task  = URLSession.shared.dataTask(with: accessRequest as URLRequest, completionHandler: getAuthorisationToken)
task.resume()
while(true) {}



//
//
//curl -F grant_type=authorization_code \
//-F client_id=c4f2f9fbfa4402b77c442dfbcb8c69ca4d047ce92bb91b631e8f3abf6ff095ed \
//-F client_secret=0b834b0534ae6f5bccd77e04c202c8d7230b16b2ad057076ab28911d3833e907 \
//-F code=41c34d7908feefcd2383d91239af67a21f49bf2ca5dab857e011d42927764e3a \
//-F redirect_uri=https://127.0.0.1 \
//-X POST https://api.intra.42.fr/oauth/token

















//
//class TokenGenerator {
//    private let CUSTOMER_KEY: String
//    private let CONSUMER_SECRET: String
//    private let BEARER: String
//    private let urlAccess:NSURL?
//    private let accessRequest: NSMutableURLRequest
//    private var task: URLSessionTask?
//    var token : String?
//    var delegate: setTokenDelegate?
//
//
//    init(del: setTokenDelegate) {
//        self.CUSTOMER_KEY = "SZDBjIVWo793xcJ7Cj0MgB9XM"
//        self.CONSUMER_SECRET = "w4G0TZsnOdZnO5VfTaJsidFX9oTft6YCZuBwj9ZlnNMiKWto0X"
//        self.BEARER  = ((CUSTOMER_KEY + ":" + CONSUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        self.urlAccess = NSURL(string: "https://api.intra.42.fr")
//        self.accessRequest = NSMutableURLRequest(url: urlAccess! as URL)
//        setupAccessRequest()
//        self.task  = URLSession.shared.dataTask(with: accessRequest as URLRequest, completionHandler: getAuthorisationToken)
//        self.delegate = del
//
//        self.task?.resume()
//    }
//
//
//    func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?) {
//        if let err = error {
//            print(err)
//            return
//        }
//        if let d = data {
//            do {
//                if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    token = dic.value(forKey: "access_token") as? String
//                    delegate?.setToken(token!)
//                    print(dic)
//                }
//            }
//            catch (let err) {
//                print(err)
//            }
//        }
//    }
//
//}
//
//
