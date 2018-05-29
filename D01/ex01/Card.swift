import Foundation

class Card: NSObject {
    var color : Color
    var value : Value

    override var description: String {
        return "\(self.color) of \(self.value)"
    }

    init(Color color:Color, Value value:Value) {
        self.color = color
        self.value = value
        super.init()
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card{
            return (obj.color == self.color && obj.value == self.value)
        }
        return false
    }
}

func ==(cardone: Card, cardtwo: Card) -> Bool
{
    return (cardone.color == cardtwo.color && cardone.value == cardtwo.value )
}
