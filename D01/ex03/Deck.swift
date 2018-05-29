import Foundation

class Deck: NSObject {
    static let allSpades    : [Card] = Value.allValue.map({Card(c:Color.Spade, v:$0)})
    static let allHearts    : [Card] = Value.allValue.map({Card(c:Color.Heart, v:$0)})
    static let allClubs     : [Card] = Value.allValue.map({Card(c:Color.Club, v:$0)})
    static let allDiamonds  : [Card] = Value.allValue.map({Card(c:Color.Diamond, v:$0)})
    static let allCards     : [Card] = allSpades + allHearts + allClubs + allDiamonds
}

extension Array {
    mutating func shuffle(){
        for i in indices {
            let j = Int(arc4random_uniform(UInt32(self.count - i))) + i
            if (j != i){
                self.swapAt(i,j)
            }
        }
    }
}
