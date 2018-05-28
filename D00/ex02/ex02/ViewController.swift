//
//  ViewController.swift
//  ex02
//
//  Created by Sydney COHEN on 5/28/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultlabel.text = "0"
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
    }
    

    @IBOutlet weak var resultlabel: UILabel!
    @IBAction func numberPressed(_ sender: UIButton) {
            print("\(sender.tag)")
            runningNumber += "\(sender.tag)"
            resultlabel.text = runningNumber
    }
    @IBAction func onACPressed(_ sender: UIButton) {
        print("AC")
        result = "0"
        runningNumber = ""
        leftValStr = "0"
        rightValStr = "0"
        resultlabel.text = "0"
        currentOperation = Operation.Empty
    }
    @IBAction func OnNegPressed(_ sender: UIButton) {
        print("NEG")
        if (runningNumber != "") {
            runningNumber = "\(-1 * Double(runningNumber)!)"
            resultlabel.text = runningNumber
        } else if leftValStr != "" {
            leftValStr = "\(-1 * Double(leftValStr)!)"
            resultlabel.text = leftValStr
        }
        
    }
    @IBAction func OnAddPressed(_ sender: UIButton) {
        print("+")
        processOperation(operation: .Add)
    }
    @IBAction func onSubtractPressed(_ sender: UIButton) {
        print("-")
        processOperation(operation: .Subtract)
    }
    @IBAction func onDividePressed(_ sender: UIButton) {
        print("/")
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(_ sender: UIButton) {
        print("*")
        processOperation(operation: .Multiply)
    }
    @IBAction func onEqualPressed(_ sender: UIButton) {
        print("=")
        if leftValStr != "" {
            processOperation(operation: currentOperation)
        }
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                if leftValStr != ""
                {
                    if currentOperation == Operation.Multiply
                    {
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    } else if currentOperation == Operation.Divide {
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    } else if currentOperation == Operation.Subtract {
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    } else if currentOperation == Operation.Add {
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    }
                }
                leftValStr = result
                resultlabel.text = result
            }
            currentOperation = operation
        }
        else
        {
            //first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

    
}

