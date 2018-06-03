

import Foundation


extension String {
    var forumTimeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let myString = self.components(separatedBy: ".")[0]
        if myString == nil {
            return ""
        }
        let mydate = dateFormatter.date(from: myString)
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        let new = dateFormatter.string(from: mydate!)
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
    var tmpData = try? JSONDecoder().decode([T].self, from: data)
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
    var tmpData = try? JSONDecoder().decode(T.self, from: data)
    return tmpData
}
