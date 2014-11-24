//
//  ViewController.swift
//  fiboApp
//
//  Created by Louis Konig on 11/19/14.
//  Copyright (c) 2014 Louis Konig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderMaxNum: UISlider!
    @IBOutlet weak var txtMaxNum: UITextField!
    @IBOutlet weak var txtNumItems: UITextField!
    @IBOutlet weak var txtFibValues: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func updateNum(sender: AnyObject) {
        txtMaxNum.text = "\(sliderMaxNum.value)"
        
        let maxNum = UInt(sliderMaxNum.value)
        let fibSequence = FibonacciSequence(maxNumber: maxNum, includesZero: true)
        txtFibValues.text = "\(fibSequence.values)"
        
        let numItems = fibSequence.values.count
        println(numItems)
        txtNumItems.text = "\(numItems)"
    
    }
    
    @IBAction func updateNumItems(sender: AnyObject) {
        
        
        let numItemsSequence = txtNumItems.text
        let numItemsSequence2 = numItemsSequence.toInt()
        let numItemsSequence3 = UInt(numItemsSequence2!)
        
        
        //let fibSequence = FibonacciSequence(numberOfItemsInSequence: numItemsSequence, includesZero: true)
        
let anotherSequence = FibonacciSequence(numberOfItemsInSequence: numItemsSequence3, includesZero: true)
        
    txtFibValues.text = "\(anotherSequence.values)"
        
        
    }
    
    
   
}


class FibonacciSequence {
    
    let includesZero: Bool
    let values: [UInt]
    
    init(maxNumber: UInt, includesZero: Bool) {
        self.includesZero = includesZero
        if maxNumber == 0 && includesZero == false {
            values = []
        } else if maxNumber == 0 {
            values = [0]
        } else {
            var sequence: [UInt] = [0,1,1]
            var nextNumber: UInt = 2
            while nextNumber <= maxNumber {
                sequence.append(nextNumber)
                let lastNumber = sequence.last!
                let secondToLastNumber = sequence[sequence.count-2]
                nextNumber = secondToLastNumber + lastNumber
            }
            if includesZero == false {
                sequence.removeAtIndex(0)
            }
            values = sequence
        }
    }
    
    init(numberOfItemsInSequence: UInt, includesZero: Bool) {
        self.includesZero = includesZero
        if numberOfItemsInSequence == 0 {
            values = []
        } else if numberOfItemsInSequence == 1 {
            if includesZero == true {
                values = [0]
            } else {
                values = [1]
            }
        } else {
            var sequence: [UInt]
            if includesZero == true {
                sequence = [0,1]
            } else {
                sequence = [1,1]
            }
            for var i: UInt = 2; i < numberOfItemsInSequence; i++ {
                let lastNumber = sequence.last!
                let secondToLastNumber = sequence[sequence.count-2]
                let (nextNumber, didOverflow) = UInt.addWithOverflow(lastNumber, secondToLastNumber)
                if didOverflow == true {
                    println("Overflow! The next number is too big to store in a UInt!")
                    break
                }
                sequence.append(nextNumber)
            }
            values = sequence
        }
    }
}

