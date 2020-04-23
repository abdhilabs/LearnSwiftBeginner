//
//  DetailController.swift
//  Data Pegawai
//
//  Created by Abdhi on 23/04/20.
//  Copyright © 2020 Abdhilabs. All rights reserved.
//

import UIKit
import CoreData

class DetailController: UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var firstNameDetail: UILabel!
    @IBOutlet weak var lastNameDetail: UILabel!
    @IBOutlet weak var emailDetail: UILabel!
    @IBOutlet weak var birthDateDetail: UILabel!
    
    var employeesID = 0
    
    //deklarasi core data dari appdelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(edit))
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteAction))
        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]
    }
    
    @objc func edit(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "addFormEmployeesController") as! AddFormEmployeesController
        controller.employeesID = employeesID
        self.navigationController?.pushViewController(controller, animated: true )
    }
    
    @objc func deleteAction(){
        let alertController = UIAlertController(title: "Warning", message: "Are you sure to delete this item?", preferredStyle: .actionSheet)
        let alertActionYes = UIAlertAction(title: "Yes", style: .default) {(action) in
            let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
            employeesFetch.fetchLimit = 1
            //kondisi dengan predicate
            employeesFetch.predicate = NSPredicate(format: "id == \(self.employeesID)")
            
            // run
            let result = try! self.context?.fetch(employeesFetch)
            let employeesToDelete = result?.first as! NSManagedObject
            self.context?.delete(employeesToDelete)
            
            do {
                try self.context?.save()
            } catch{
                print(error.localizedDescription)
            }
            self.navigationController?.popViewController(animated: true)
        }
        self.present(alertController,animated: true, completion: nil)
        let alertActionNo = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(alertActionYes)
        alertController.addAction(alertActionNo) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
        employeesFetch.fetchLimit = 1
        //kondisi dengan predicate
        employeesFetch.predicate = NSPredicate(format: "id == \(employeesID)")
        
        // run
        let result = try! context?.fetch(employeesFetch)
        let employees: Employees = result?.first as! Employees
        firstNameDetail.text = employees.firstName
        lastNameDetail.text = employees.lastName
        emailDetail.text = employees.email
        birthDateDetail.text = employees.birthDate
        
        if let imageData = employees.image {
            imageDetail.image = UIImage(data: imageData as Data)
            imageDetail.layer.cornerRadius = imageDetail.frame.height / 2
            imageDetail.clipsToBounds = true
        }
        self.navigationItem.title = "\(employees.firstName!) \(employees.lastName!)"
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
