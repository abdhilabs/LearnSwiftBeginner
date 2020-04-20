//
//  ViewController.swift
//  FindMyAge
//
//  Created by Abdhi on 20/04/20.
//  Copyright © 2020 Abdhilabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateMyAge(_ sender: Any) {
        //Get selected date from date picker
        let birthDate = self.datePicker.date //(yyyy-mm-dd hh:mm:ss)
        
        let today = Date()
        
        if birthDate >= today {
            let alerController = UIAlertController(title: "Error", message: "Please enter a valid date", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alerController.addAction(alertAction)
            self.present(alerController, animated: true, completion: nil)
            return
        }
        let calendar = Calendar.current
        
        let component = calendar.dateComponents([.year,.month,.day], from: birthDate, to: today)
        
        guard let ageYears = component.year else {return}
        guard let ageMonth = component.month else {return}
        guard let ageDay = component.day else {return}
        
        self.ageLabel.text = "\(ageYears) years, \(ageMonth) month, \(ageDay) day"
    }
    
}

