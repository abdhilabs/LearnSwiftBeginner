//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Abdhi on 20/04/20.
//  Copyright © 2020 Abdhilabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var operation = 0
    var performingMath = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true {
            resultLabel.text = String(sender.tag - 1)
            numberOnScreen = Double(resultLabel.text!)!
            performingMath = false
        }else{
            resultLabel.text = resultLabel.text! + String(sender.tag - 1)
            numberOnScreen = Double(resultLabel.text!)!
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 15 && sender.tag != 16 {
            previousNumber = Double(resultLabel.text!)!
            if sender.tag == 11 {
                resultLabel.text = "/"
            } else if sender.tag == 12{
                resultLabel.text = "X"
            } else if sender.tag == 13{
                resultLabel.text = "-"
            } else if sender.tag == 14{
                resultLabel.text = "+"
            }
            operation = sender.tag
            performingMath = true
            
        } else if sender.tag == 15{
            if operation == 11 {
                resultLabel.text = String(previousNumber / numberOnScreen)
            } else if operation == 12{
                resultLabel.text = String(previousNumber * numberOnScreen)
            } else if operation == 13{
                resultLabel.text = String(previousNumber - numberOnScreen)
            } else if operation == 14{
                resultLabel.text = String(previousNumber + numberOnScreen)
            }
        } else if sender.tag == 16{
            resultLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
}

