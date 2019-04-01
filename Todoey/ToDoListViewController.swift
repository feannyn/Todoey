//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas Feanny on 3/2/19.
//  Copyright © 2019 Nicholas Feanny. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

  //  var itemArray = ["Find Mike", "Buy Eggos", "Kill Monster"]
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

   //var defaults: UserDefaults = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         //urls is an array and we want the first item in that array
        
        print(dataFilePath!)
        
        let newItem: Item = Item()
        newItem.job = "Find Mike"
        itemArray.append(newItem)
        
        saveItems()
       
        
        

    }
    
    //MARK - TablewView Datasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //we create a cell and reuse the idex off screeen to load new data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
   
        //textLabel is an optional which represents the "label imbedded in every cell"
        cell.textLabel?.text = itemArray[indexPath.row].job
        
        //ternary operation
        cell.accessoryType = itemArray[indexPath.row].complete ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview delegate methods
    
    
    //what happens when the cell is "clicked"
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])//prints THE ITEM HELD BY THE ROW into the console when we select a particular item in the tableview, i.e., the specific row
        
        /*Rather than just making a giant if statement swapping values if... we just set the reverse in one line when the cell is clicked*/
        itemArray[indexPath.row].complete = !itemArray[indexPath.row].complete
        
        saveItems()
        
        
        
        //causes the selection to not remain highlighted forever...
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    
    //MARK - Add new Items
    
    //what happens when the "add item" button is clicked"
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "Add new ToDo List Item", message: "Please enter an item", preferredStyle: .alert)//1
        
        var addedItem: UITextField = UITextField()//2
        
        
        //place textfield within the alert.
        alert.addTextField { (alertTextField) in //3
            alertTextField.placeholder = "Please enter the ToDo List Item here..."//4
            
            //reference to the text entered inside the textfield.
            //"Pointer to location in memory of the alertTextField so it can be referenced later in a different scope."
            addedItem = alertTextField//5

        }
        
        //once add item is pressed, we can append the text referenced in the alert textfield to the item array
        let action: UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in //6
            //what happens once the user clicks the Add Item button on the UIALert
            
            
            //create a new item and add it to the array
            let newItem: Item = Item()//7
            newItem.job = addedItem.text!//8
            self.itemArray.append(newItem)//9
            
            print("Success... UIAlert was pressed!")//10
            print(addedItem.text!)//11
            
            //Sets the value of data added to, in this case, the itemArray so when the application is terminated
            //it will be saved in the sandbox associated with the application.
            //(Data added and deleted is not lost.
          //  self.defaults.set(self.itemArray, forKey: "ToDoListArray")//12
            
            
            //encodes the added item to the Items.plist file and reloads the data
            self.tableView.reloadData()
            
            
            //This is the tableView which the controller manages and we are reloading it with the newly updated list
            //self.tableView.reloadData() //13
            
        }
        
        alert.addAction(action) //14
        
        present(alert, animated: true, completion: nil) //15
        
    }
    
    
    func saveItems() {
        let encoder: PropertyListEncoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch  {
            print("Error encoding the item array: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
}

