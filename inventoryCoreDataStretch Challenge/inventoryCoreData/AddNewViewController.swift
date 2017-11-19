

//  AddNewViewController.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/13/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    let stack = CoreDataStack.instance
    
    
    var inventory: Inventory?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.inventory != nil {
            nameTextField.text = self.inventory?.name!
            amountTextField.text = self.inventory?.detail!
        }
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if self.inventory == nil {
            let newInventory = Inventory(context: stack.downloadContext)
            newInventory.date = Date()
            newInventory.name = nameTextField.text!
            newInventory.detail = amountTextField.text!
            self.inventory = newInventory
            
        } else {
            self.inventory?.name = nameTextField.text!
            self.inventory?.detail = amountTextField.text!
            self.inventory?.date = self.inventory?.date!
        }
        stack.saveTo(context: stack.downloadContext)
        
        self.performSegue(withIdentifier: "unwindToViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "unwindToViewController" {
                let destination = segue.destination as! ViewController
                destination.inventoryList.append(self.inventory!)
            }
        }
    }
    
    
    
}
