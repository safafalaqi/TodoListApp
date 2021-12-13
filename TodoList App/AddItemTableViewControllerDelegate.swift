//
//  AddItemTableViewControllerDelegate.swift
//  TodoList App
//
//  Created by Safa Falaqi on 13/12/2021.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class{
    
    func itemSaved(by controller:AddItemTableViewController, title t: String , note n: String, date d:Date , at indexPath:NSIndexPath?)
    func cancelButtonPressed(by controller:AddItemTableViewController)
    
}
