

import Foundation


extension String {
    var forumTimeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let myStrings = self.components(separatedBy: ".")
        guard myStrings.count == 2 else { return "" }
        let myString = myStrings[0]
        if myString == "" {
            return ""
        }
        let mydate = dateFormatter.date(from: myString)
        guard let date = mydate else { return "" }
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        let new = dateFormatter.string(from: date)
        return new 
    }
}

//func decodeData(data: Data) {
//    var tmpData = try? JSONDecoder().decode([Topic].self, from: data)
//    print(tmpData)
//    print(tmpData![0].created_at.forumTimeFormat)
//    print(tmpData![0].created_at)
//
//
//    for (index,topic) in tmpData!.enumerated() {
//        tmpData![index].created_at = topic.created_at.forumTimeFormat
//    }
//    print(tmpData)
//}

func decodeDataArray<T>(data: Data) -> [T]? {
    let tmpData = try? JSONDecoder().decode([T].self, from: data)
//    print(tmpData)
//    print(tmpData![0].created_at.forumTimeFormat)
//    print(tmpData![0].created_at)
    
    
//    for (index,topic) in tmpData!.enumerated() {
//        tmpData![index].created_at = topic.created_at.forumTimeFormat
//    }
//    print(tmpData)
    return tmpData
}

func decodeData<T>(data: Data) -> T? where T: Decodable {
    let tmpData = try? JSONDecoder().decode(T.self, from: data)
    return tmpData
}
