//: Playground - noun: a place where people can play

import UIKit

var str = "ecole42"

struct Tweet: CustomStringConvertible {
    let name : String
    let text : String
    let date: String
    var description: String {
        return "\(name), \(text)"
    }
}

struct Credentials {
    static let CUSTOMER_KEY = "OjHFXl9MDC8HiCun2h2RXcAkB"
    static let CUSTOMER_SECRET = "n3c5XtLPTTQeqEEt4jocIVEmwn14hQTDTn18T6oWucmO5sn77q"
    static let TOKEN = "AAAAAAAAAAAAAAAAAAAAAON16QAAAAAAOc%2FeDlOX6s2bqaJCgWdZJb6o11c%3DTKj6DWZ5LXBc4WYZ4N5BWOpqlT3gPt1QmbYoiCWfK2uO1sehuZ"
}


protocol APITwitterDelegate : class {
    func receiveTweets (tweets : [Tweet])
    func errorTweets (error : NSError)
}

class APIController {
    weak var delegate : APITwitterDelegate?
    private let token : String
    private let twitterURL = "https://api.twitter.com/1.1/"
    private static let searchTweetsURL = "https://api.twitter.com/1.1/" + "search/tweets.json"
    
    init (token: String) {
        self.token = token;
//        self.delegate = delegate
    }
    
    
    
    func retrieve(search: String) {
        print(search)
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + search)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.delegate?.errorTweets(error: error! as NSError)
                })
                return
            }
            
            let d = data
            do {
                var twits: [Tweet] = []
                if let resp: NSDictionary = try JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let statuses: [NSDictionary] = resp["statuses"] as? [NSDictionary] {
                        for status in statuses {
                            let name = (status["user"] as? NSDictionary)?["name"] as? String
                            let text = status["text"] as? String
                            let date = status["created_at"] as? String
                            if (name != nil) && (text != nil) && (date != nil) {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let date = dateFormatter.date(from: date!) {
                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate = dateFormatter.string(from: date)
                                    print(name!, text!, newDate)
                                    twits.append(Tweet(name: name!, text: text!, date: newDate))
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.delegate?.receiveTweets(tweets: twits)
                        }
                    }
                }
                print(twits)
            } catch (let err){
                DispatchQueue.main.async(execute: {
                    self.delegate?.errorTweets(error: err as NSError)
                })
                return
            }
            
        }
       
        task.resume()
        print(Tweet.self)
    }
}

var control = APIController(token: Credentials.TOKEN)
control.retrieve(search: "ecole42")


