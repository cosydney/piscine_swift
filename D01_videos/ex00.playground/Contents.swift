//: Playground - noun: a place where people can play

enum Color : String {
    case hearts = "hearts"
    case diamonds = "diamonds"
    case clubs = "clubs"
    case spades = "spades"
    static let allColor : [Color] = [hearts, diamonds, clubs, spades]
}

enum Value : Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    static let allValue : [Value] = [
    ace,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine,
    ten,
    jack,
    queen,
    king
    ]
}

import Foundation

var arrayValue : [Value] = Value.allValue
var arrayColor : [Color] = Color.allColor

for value in arrayValue {
    print (value, "is", value.rawValue)
}

for color in arrayColor {
    print (color, "is", color.rawValue)
}




