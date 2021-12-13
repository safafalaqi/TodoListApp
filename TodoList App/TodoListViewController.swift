//
//  ViewController.swift
//  TodoList App
//
//  Created by Safa Falaqi on 13/12/2021.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController,AddItemTableViewControllerDelegate {
 
    var todoList = [TodoList]()
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
     
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoList.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
                 
                cell.accessoryType = .checkmark
                 //update checked in coredata
                 let item = todoList[indexPath.row]
                 item.checked = true
                 saveContext()
                 tableView.reloadData()
               
           }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        //set all cell data
        cell.titleLabel.text = todoList[indexPath.row].title!
        cell.noteLabel.text = todoList[indexPath.row].note!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate = dateFormatter.string(from: todoList[indexPath.row].dueDate!)
        cell.dateLabel.text = strDate
        
        cell.backgroundColor = UIColor.clear
       
        //here check if checked is set to true in coredata
      
        cell.accessoryType = todoList[indexPath.row].checked ? .checkmark : .none
        
        
        return cell
        
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addItemSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
              let navigationController = segue.destination as! UINavigationController
              let addItemTabelController = navigationController.topViewController as! AddItemTableViewController
              addItemTabelController.delegate = self
    
      }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")
        do{
            let result = try manageObjectContext.fetch(request)
            todoList = result as! [TodoList]
        }catch{
            print("\(error)")
        }
        
    }
 
    func itemSaved(by controller: AddItemTableViewController, title t: String, note n: String, date d: Date, at indexPath: NSIndexPath?) {

            let item = NSEntityDescription.insertNewObject(forEntityName: "TodoList", into: manageObjectContext) as! TodoList
            item.title = t
            item.note = n
            item.dueDate = d
            item.checked = false
            todoList.append(item)
       
            saveContext()

            tableView.reloadData()
            dismiss(animated: true)
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        manageObjectContext.delete(item)
        saveContext()
        todoList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
  
    
}

