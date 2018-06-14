import Foundation

class Card: NSObject {
    var c : Color
    var v : Value

    override var description: String {
        if self.v.rawValue > 10 {
            return "(\(self.v), \(self.c))"
        } else {
            return "(\(self.v.rawValue), \(self.c))"
        }
    }

    init(c: Color, v: Value) {
        self.c = c
        self.v = v
        super.init()
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card{
            return (obj.c == self.c && obj.v == self.v)
        }
        return false
    }
}

func ==(cardone: Card, cardtwo: Card) -> Bool
{
    return (cardone.c == cardtwo.c && cardone.v == cardtwo.v )
}
