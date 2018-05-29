//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var optInt: Int? = 4

if let number = optInt {
    print(number)
}

struct PointStruct {
    var x: Double
    var y: Double
    
    mutating func makeOrigin() {
        x = 0
        y = 0
    }
}


class PointClass {
    var x: Double
    var y: Double
    
    init (x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func makeOrigin() {
        x = 0
        y = 0
    }
    
    func toString() -> String {
        return "\(x) \(y)"
    }
}

PointClass(x: 8, y:8).toString()

extension PointStruct {
    func toString() -> String {
        return "\(x) \(y)"
    }
}


//var p1 = PointClass(x: 21, y: 21)
var p1 = PointStruct(x: 21, y: 21)
var p2 = p1

print(p1.toString())
print(p2.toString())
p1.x = 0
print(p1.toString())
print(p2.toString())



//ENUM

enum TrafficLight {
    case Green
    case Red
    case Orange
}

let light = TrafficLight.Orange
light.hashValue


enum DoorState: String {
    case Open = "The Door is open"
    case Closed = "The door is closed"
}

let door = DoorState.Open
door.rawValue


//enum Option {
//    case Nil
//    case Value(Int)
//}

enum Option<T> {
    case Nil
    case Value(T)
}

var intOpt = Option.Value(42)


switch intOpt {
case .Nil:
    print("Number is Nil")
case .Value (let n):
    print ("Number is equal to \(n)")
}
