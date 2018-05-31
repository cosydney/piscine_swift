//: Playground - noun: a place where people can play

import UIKit

let qos = DispatchQoS.background.qosClass
//let qos = DispatchQoS.userInteractive.qosClass
//let qos = DispatchQoS.utility.qosClass

let queue = DispatchQueue.global(qos: qos)

queue.async {
//    DispatchQueue.main.async {
//        imageView.image = UIim
//    }
    print("This come from an other queue")
}

print("This is the main queue")
