//: Playground - noun: a place where people can play

// Color
enum Color : String {
    case Heart = "Heart"
    case Diamond = "Diamond"
    case Club = "Club"
    case Spade = "Spade"
    static let allColor : [Color] = [Heart, Diamond, Club, Spade]
}

//Value
enum Value : Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    static let allValue : [Value] = [
        Ace,
        Two,
        Three,
        Four,
        Five,
        Six,
        Seven,
        Eight,
        Nine,
        Ten,
        Jack,
        Queen,
        King
    ]
}

//Card
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

//Deck
import Foundation

class Deck: NSObject {
    static let allSpades    : [Card] = Value.allValue.map({Card(c:Color.Spade, v:$0)})
    static let allHearts    : [Card] = Value.allValue.map({Card(c:Color.Heart, v:$0)})
    static let allClubs     : [Card] = Value.allValue.map({Card(c:Color.Club, v:$0)})
    static let allDiamonds  : [Card] = Value.allValue.map({Card(c:Color.Diamond, v:$0)})
    static let allCards     : [Card] = allSpades + allHearts + allClubs + allDiamonds
    var cards               : [Card] = allSpades + allHearts + allClubs + allDiamonds
    var discards            : [Card] = []
    var outs                : [Card] = []
    
    init(shuffle:Bool) {
        if shuffle {
            cards.shuffle()
        }
        super.init()
    }
    
    override var description: String {
        return "\(self.cards)"
    }
    
    func draw() -> Card? {
        let firstcard : Card?
        firstcard = self.cards.first
        if firstcard != nil {
            outs.append(firstcard!)
            cards.removeFirst()
            return firstcard
        }
        else {
            return nil
        }
    }
    
    func fold(c: Card) {
        if let found = outs.index(of: c) {
            outs.remove(at: found)
            discards.append(c)
        }
    }
    
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


// Main ex04
print("Tacking a shuffled deck")
var shufflecards = Deck(shuffle: true)
print(shufflecards)

print("Tacking a sorted deck")
var sorted = Deck(shuffle: false)
print("\n\n taking a sorted deck")
print(sorted)
print("\ndrawing first two card of a sorted deck")
var draw = sorted.draw()
draw = sorted.draw()
print(sorted)
print("**printing cards out:", sorted.outs)

var shuffledeck0 = Deck(shuffle: true)
print("\n\n taking a shuffledeck0 deck")
print(shuffledeck0)
print("\ndrawing first two card of a shuffledeck0 deck")
draw = shuffledeck0.draw()
draw = shuffledeck0.draw()
print(shuffledeck0)
print("printing cards out:", shuffledeck0.outs)

var shuffleddeck = Deck(shuffle: true)
print("\n\n taking a shuffled deck")
print(shuffleddeck)
print("\ndrawing all cards + 1 of a shuffled deck")
for _ in shuffleddeck.cards {
    draw = shuffleddeck.draw()
}
print(shuffleddeck)
print("printing cards out:", shuffleddeck.outs)

var shuffled2 = Deck(shuffle: true)
print("\n\n taking a new shuffled deck\n\n", shuffled2)
var handpicker = shuffled2.cards[1]
print("\n\nhandpicking a card from a shuffled deck", handpicker)
print("\ndrawing first two cards of a shuffled deck")
draw = shuffled2.draw()
draw = shuffled2.draw()
print("cards out:", shuffled2.outs)
print("cards discards:", shuffled2.discards)
print("\nfolding selected cards:", handpicker)
shuffled2.fold(c: handpicker)
print("cards out:", shuffled2.outs)
print("cards discards:", shuffled2.discards)





// Main ex03
//var shufflecards = Deck.allCards
//print("Taking a brand new deck")
//print(shufflecards)
//print("Shuffling cards")
//shufflecards.shuffle()
//print(shufflecards)
//print("Shuffling cards again")
//shufflecards.shuffle()
//print(shufflecards)


//Main ex02
//print("Total number of cards in the deck:", Deck.allCards.count)
//print(Deck.allSpades)
//print(Deck.allHearts)
//print(Deck.allClubs)
//print(Deck.allDiamonds)
//print(Deck.allCards)

////Main ex 00
//import Foundation
//
//var arrayValue : [Value] = Value.allValue
//var arrayColor : [Color] = Color.allColor
//
//for value in arrayValue {
//    print (value, "is", value.rawValue)
//}
//
//for color in arrayColor {
//    print (color, "is", color.rawValue)
//}

////Main ex01
//let card1 : Card = Card(c: Color.Spade, v: Value.Ace)
//let card2 : Card = Card(c: Color.Diamond, v: Value.Two)
//let card3 : Card = Card(c: Color.Spade, v: Value.Ace)
//let card4 : Card = Card(c: Color.Spade, v: Value.Jack)
//
//print ("card1:", card1)
//print ("card2:", card2)
//print ("card3:", card3)
//print ("card4:", card4)
//
//print("\n Testing isEqual")
//print("card1.isEqual(card2) should evaluate to false:", card1.isEqual(card2))
//print("card1.isEqual(card3) should evaluate to true:", card1.isEqual(card3))
//print("card2.isEqual(card3) should evaluate to false:", card2.isEqual(card3))
//
//print("\n Testing ==")
//print("card1 == card2, should evaluate to false:", card1 == card2)
//print("card1 == card3, should evaluate to true:", card1 == card3)
//print("card2 == card3, should evaluate to false:", card2 == card3)

