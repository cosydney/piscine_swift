//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Person {
    var name: String

    var age: Int {
        willSet{
            print("\(name) will change his age from \(age) to \(newValue)")
        }
        didSet{
            print("\(name) did change his age from \(oldValue) to \(age)")
        }
    }

    //Computed properties

    var description: String {
        return "Name : \(name), age: \(age)"
    }

    var isMinor: Bool {
        get{
            return age < 18
        }
        set {
            if newValue {
                age = 17
            }
            else {
                age = 18
            }
        }
    }
}

var joe = Person(name: "Joe le taxi", age: 12)

joe.description
joe.isMinor
joe.age = 32
joe.isMinor


var operations : [String : (Int, Int) -> Int] = [:]

func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

operations["+"] = add

operations["+"]!(2, 3)

operations["-"] = {
    (n1: Int, n2: Int) -> Int in
    return n1 - n2
}

operations["*"] = {
    return $0 * $1
}

operations["/"] = {
    return $0 / $1
}

operations["+"] = (+)

