//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Dev on 29/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("items.plist")

    
    //.standard is referring to singleton, it will always point to a single instance of user defaults plist
    
    //in builtin table view controller we dont need to make IBoutlets or use any delegate = self things because its already done for us from xcode
    
    var itemArray = [Items]() //array of item objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
//        if let item = defaults.array(forKey: "todo") as? [String]{
//            itemArray = item
//        }
    }
    
    //MARK: - TableViewDataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //when our tableview loads, we have to load data from plist file so our checkmarks remain as we left them
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK: - TableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //when user clicks on a row we change our property value too for storage purposes
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - add new item
    
    @IBAction func itemButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            var newItem = Items()
            newItem.title = textField.text ?? ""
            self.itemArray.append(newItem)
            //after appending in array put it in user defaults
            //self.defaults.set(self.itemArray, forKey: "todo")
            self.saveData()
            
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            do{
                try data.write(to: dataFilePath)
            }catch{print("can not encode data")}
        }catch{print("can not encode data")}
        self.tableView.reloadData()
        
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Items].self, from: data)
            }catch{
                print("can not decode data")
            }
        }
    }
    
    
}

