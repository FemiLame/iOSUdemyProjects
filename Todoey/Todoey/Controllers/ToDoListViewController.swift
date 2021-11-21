//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    var items: Results<Item>?
    let realm = try! Realm()
    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let colourHex = UIColor(hexString: selectedCategory?.hexColor ?? "#000000") {
//            title = selectedCategory!.name
//            guard let navBar = navigationController?.navigationBar else {
//                fatalError("Navigation controller does not exist.")
//            }
//
//            navBar.backgroundColor = colourHex
//            navBar.tintColor = ContrastColorOf(colourHex, returnFlat: true)
////            navBar.barTintColor = colourHex
//
//            searchBar.barTintColor = colourHex
//            navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(colourHex, returnFlat: true)]
////            addButton.tintColor = ContrastColorOf(colourHex, returnFlat: true)
//
//        }
        if let colourHex = selectedCategory?.hexColor {
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
            }
            if let navBarColour = UIColor(hexString: colourHex) {
                //Original setting: navBar.barTintColor = UIColor(hexString: colourHex)
                //Revised for iOS13 w/ Prefer Large Titles setting:
                searchBar.barTintColor = navBarColour
                
                
                if #available(iOS 13.0, *) {
                    let navBarAppearance = UINavigationBarAppearance()
                    navBarAppearance.configureWithOpaqueBackground()
                    navBarAppearance.titleTextAttributes = [.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
                    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
                    navBarAppearance.backgroundColor = navBarColour
                    
                    navBar.standardAppearance = navBarAppearance
                    navBar.scrollEdgeAppearance = navBarAppearance
                } else {
                    navBar.backgroundColor = navBarColour
                    navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                }
                
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
            }
        }
    }
    //MARK: - TableView Delegate methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //            let newItem = Item(context: self.context)
            
            if let category = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = alertTextField.text!
                        newItem.isDone = false
                        //                        newItem.dateCreated = Date()
                        category.items.append(newItem)
                    }
                } catch {
                    print("Error saving context \(error)")
                }
            }
            
            self.tableView.reloadData()
            
            //            newItem.parentCategory = self.selectedCategory
            //            self.itemArray.append(newItem)
            
            //            self.safeItems()
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Create new Item"
            alertTextField = textField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    item.isDone = !item.isDone
                }
            } catch {
                print("Error while changeing isDone property \(error)")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        
        //        let item = items?[indexPath.row]
        //        item.isDone = !item.isDone
        //
        //        self.safeItems()
        //
        //        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.items?[indexPath.row] {
            do {
                try self.realm.write() {
                    self.realm.delete(item)
                }
            } catch {
                print("Error deleting item \(error)")
            }
            //            tableView.reloadData()
        }
    }
    
}

//MARK: - TableView Datasource methods

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isDone ? .checkmark : .none
            let color = UIColor(hexString: selectedCategory!.hexColor!)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(items!.count))
            cell.backgroundColor = color
            cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: color!, isFlat: true)
            
            
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
        
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
    //
    //        if let item = items?[indexPath.row] {
    //            cell.textLabel?.text = item.title
    //            cell.accessoryType = item.isDone ? .checkmark : .none
    //        } else {
    //            cell.textLabel?.text = "No items added"
    //        }
    //
    //        return cell
    //    }
}

// MARK: - Model Manipulation methods

extension ToDoListViewController {
    //    func safeItems() {
    //        do {
    //            try context.save()
    //        } catch {
    //            print("Error saving context \(error)")
    //        }
    //
    //        self.tableView.reloadData()
    //    }
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        //    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", parentCategory!.name!)
        //
        //        if let additionalPredicate = predicate {
        //            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate, categoryPredicate])
        //        } else {
        //            request.predicate = categoryPredicate
        //        }
        //
        //
        //        do {
        //            itemArray = try context.fetch(request)
        //        } catch {
        //            print("error fetching data from the context \(error)")
        //        }
        
        tableView.reloadData()
    }
}

// MARK: - Search bar delegate methods

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        //        let request: NSFetchRequest<Item> = Item.fetchRequest()
        //        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //
        //        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


