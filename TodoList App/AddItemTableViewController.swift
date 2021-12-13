//
//  AddItemTableViewController.swift
//  TodoList App
//
//  Created by Safa Falaqi on 13/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    var indexPath:NSIndexPath?
    
    
    weak var delegate:AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 30
    }

    
    @IBAction func addItemPressed(_ sender: Any) {
    
        delegate?.itemSaved(by: self, title: titleField.text!, note: detailField.text!, date: date.date, at: nil)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
}
