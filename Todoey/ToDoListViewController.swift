//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas Feanny on 3/2/19.
//  Copyright © 2019 Nicholas Feanny. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Kill Monster"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    }
    
    //MARK - TablewView Datasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
   
        
        //textLabel is an optional which represents the "label imbedded in every cell"
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
    }
    
    //MARK - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])//prints THE ITEM HELD BY THE ROW into the console when we select a particular item in the tableview, i.e., the specific row
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "Add new ToDo List Item", message: "Please enter an item", preferredStyle: .alert)
        
        var addedItem: UITextField = UITextField()
        
        
        //place textfield within the alert.
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Please enter the ToDo List Item here..."
            //reference to the text entered inside the textfield.
            addedItem = alertTextField

        }
        
        //once add item is pressed, we can append the text referenced in the alert textfield to the item array
        let action: UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens once the user clicks the Add Item button on the UIALert
            print("Success... UIAlert was pressed!")
            print(addedItem.text!)
            
            self.itemArray.append(addedItem.text!)
            print(self.itemArray[self.itemArray.endIndex - 1])
            
            
            //This is the tableView which the controller manages and we are reloading it with the newly updated list
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

