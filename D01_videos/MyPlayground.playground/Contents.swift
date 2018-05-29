//: Playground - noun: a place where people can play

import UIKit

var str1 = "Hello, playground"
var str2: String = "Coucou !"
str2 = str1


let pi  = 3.14
//pi = 2
//let pi : Float = 3.14

let tuple = (str1, pi)
print(tuple)

let anotherTuple: (String, String, Int) = ("One", "Two", 1)

print(anotherTuple)
print(anotherTuple, 2)


var fruits: [String] = [String]()
fruits.append("fraise")
fruits.append("banane")
fruits.append("pomme")

print (fruits.first)
print(fruits[2])

var personnes = [String : Int]()
personnes["Toto"] = 12
personnes["Max"]
print(personnes)

//var optInt: Int? = 3
//print(optInt)
//print(optInt!)

//optInt = 0
//print(optInt)
//print(optInt!)

var optString: String! = "foo"
print(optString)
print(optString!)


// WEAK

var button: UIButton? = UIButton()
CFGetRetainCount(button)

var buttonRef = button // type option
CFGetRetainCount(button)

button = nil
CFGetRetainCount(buttonRef)


//let gesture = UIPanGestureRecognizer()
//
//switch gesture.state {
//case .Possible :
//    print("It4s porbably a pan gesture")
//case .Began :
//    print("Began")
//case .Changed :
//    print ("Began")
//case .Failed, .Cancelled :
//    print ("error")
//case .Default:
//    print("Default")
//}
//}
