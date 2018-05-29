import Foundation

class Deck: NSObject {
    static let allSpades    : [Card] = Value.allValue.map({Card(c:Color.Spade, v:$0)})
    static let allHearts    : [Card] = Value.allValue.map({Card(c:Color.Heart, v:$0)})
    static let allClubs     : [Card] = Value.allValue.map({Card(c:Color.Club, v:$0)})
    static let allDiamonds  : [Card] = Value.allValue.map({Card(c:Color.Diamond, v:$0)})
    static let allCards     : [Card] = allSpades + allHearts + allClubs + allDiamonds
}
