//
//  ViewController.swift
//  Data Pegawai
//
//  Created by Abdhi on 21/04/20.
//  Copyright © 2020 Abdhilabs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var employees:[Employees] = []
    var filteredEmployees:[Employees] = []
    let searchController = UISearchController(searchResultsController: nil)

    //deklarasi core data dari appdelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
            employees = try context?.fetch(employeesFetch) as! [Employees]
        }catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }

    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.placeholder = "Find Employees"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        
        self.navigationItem.title = "Employees"
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.14, green: 0.86, blue: 0.73, alpha: 1.0)
        //self.navigationController?.navigationBar.tintColor = .white
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && !((searchController.searchBar.text?.isEmpty)!){
            return filteredEmployees.count
        }
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var employee = employees[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if searchController.isActive && !((searchController.searchBar.text?.isEmpty)!) {
            employee = filteredEmployees[indexPath.row]
        }else {
            employee = employees[indexPath.row]
        }
        
        cell.titleCell.text = employee.firstName
        cell.subtitleCell.text = employee.lastName
        if let imageData = employee.image {
            cell.imageCell.image = UIImage(data: imageData as Data)
            cell.imageCell.layer.cornerRadius = cell.imageCell.frame.height / 2
            cell.imageCell.clipsToBounds = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detailController") as! DetailController
        controller.employeesID = Int(employees[indexPath.row].id)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text!
        if keyword.count > 0 {
            print("Kata kunci \(keyword)")
            
            let employeesSearch = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
            
            let predicate1 = NSPredicate(format: "firstName CONTAINS[c] %@", keyword)
            let predicate2 = NSPredicate(format: "lastName CONTAINS[c] %@", keyword)
            
            let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1, predicate2])
            employeesSearch.predicate = predicateCompound
            
            // run query
            do{
                let employeesFilter = try context?.fetch(employeesSearch) as! [NSManagedObject]
                filteredEmployees = employeesFilter as! [Employees]
            } catch{
                print(error)
            }
            self.tableView.reloadData()
        }
    }
}
