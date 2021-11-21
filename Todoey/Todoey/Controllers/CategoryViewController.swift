//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alex Osipova on 10.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

//import CoreData
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    //    var categoryArray = [Category]()
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray: Results<Category>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = FlatPurple()
            navBar.standardAppearance = navBarAppearance
            navBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navBar.backgroundColor =  FlatPurple()
        }
    }
    
    

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Gategory", message: "", preferredStyle: .alert)
        var alertTextField = UITextField()
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            //            let newCategory = Category(context: self.context)
            let newCategory = Category()
            newCategory.name = alertTextField.text!
            newCategory.hexColor = UIColor.randomFlat().hexValue()
            
            self.saveCategory(category: newCategory)
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Create new Category"
            alertTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write() {
                    self.realm.delete(category)
                }
            } catch {
                print("Error deleting category \(error)")
            }
//            tableView.reloadData()
        }
    }
}


//MARK: - TableView Datasource methods
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categoryArray?[indexPath.row]
        
        cell.textLabel?.text = category?.name
        if let color = UIColor(hexString: category?.hexColor ?? "#FFFFFF") {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        return cell
    }
}

//MARK: - TableView Delegate methods
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! ToDoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray?[indexPath.row]
            }
        }
    }
}



// MARK: - Model Manipulation methods

extension CategoryViewController {
    func saveCategory(category: Category) {
        //        do {
        //            try context.save()
        //        } catch {
        //            print("Error saving category \(error)")
        //        }
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        //    with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        //        do {
        //            categoryArray =  try context.fetch(request)
        //        } catch {
        //            print("Error fetching categories \(error)")
        //        }
        //
        //        tableView.reloadData()
    }
}
