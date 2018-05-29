//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Animal {
    var numberOfLegs = 0
}

class Dog : Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
    
    func bark() {
        print("whaouf")
    }
}

class Bird : Animal {
    override init() {
        super.init()
        numberOfLegs = 2
    }
    
    func fly() {
        print("Bird fly away")
    }
}


var animals = [Animal]()

animals.append(Dog())
animals.append(Bird())
animals.append(Bird())
animals.append(Dog())
animals.append(Dog())

for animal in animals {
    if animal is Dog {
        print("It's a dog")
        let dog = animal as! Dog
        dog.bark()
    }
    else if animal is Bird {
        print("It's a bird")
    }
    else {
        print("No idea")
    }
    let bird = animal as? Bird
    bird?.fly()
}

