//
//  ViewController.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/13/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, inventoryDelegate {
    

    @IBOutlet weak var inventoryTableView: UITableView!
    
    var inventoryList: [Inventory] = []
    var cart: Cart?
    let stack = CoreDataStack.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchedCart = fetchCartFromCoreData(entityName: "Cart") as? [Cart]
        guard let cart = fetchedCart?.first else {
            let newCart = Cart(context: stack.viewContext)
            newCart.name = "User Cart"
            stack.saveTo(context: stack.viewContext)
            return
        }
        
        self.cart = cart
        
        let fetchedInventoryList = fetchInventoryFromCoreData(entityName: "Inventory") as? [Inventory]
        self.inventoryList = fetchedInventoryList!
    }
    
    func sendInventory(inventoryIndexPath: IndexPath) {
        
        
        defer {
           stack.saveTo(context: stack.downloadContext)
        }
        
        
        //test
        
        let selectedInventory = self.inventoryList[inventoryIndexPath.row]
        
        self.cart?.addToInventories(selectedInventory)
        selectedInventory.cart = self.cart
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inventoryTableView.reloadData()
//       fetchFromCoreData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.inventoryTableView.dequeueReusableCell(withIdentifier: "inventoryCell") as! InventoryTableViewCell
        cell.delegate = self as inventoryDelegate
        cell.indexPath = indexPath
        cell.inventoryLabel.text = self.inventoryList[indexPath.row].name
        cell.detailLabel.text = self.inventoryList[indexPath.row].detail
        cell.dateLabel.text = "\(String(describing: self.inventoryList[indexPath.row].date!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let coreData = CoreDataStack.instance
            let inventory = self.inventoryList[indexPath.row]
//            coreData.viewContext.delete(inventory)
//            coreData.saveTo(context: coreData.viewContext)
//            fetchFromCoreData()
            self.inventoryTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toEdit" {
                let indexPath = self.inventoryTableView.indexPathForSelectedRow!
                let inventoryToPass = self.inventoryList[indexPath.row]
                let destination = segue.destination as! AddNewViewController
                destination.inventory = inventoryToPass
            }
        }
    }
    
   @IBAction func unwindToViewController(segue:UIStoryboardSegue) { }
    

}

