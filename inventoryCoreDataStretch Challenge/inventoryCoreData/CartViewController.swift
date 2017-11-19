//
//  CartViewController.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/15/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var cartTableView: UITableView!
    
    var inventories: [Inventory]?
    var cart: Cart?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.cart == nil {
            let fetchedCart = fetchCartFromCoreData(entityName: "Cart") as? [Cart]
            if fetchedCart! == [] {
                
            }
            
            if let cart = fetchedCart?[0] {
                self.cart = cart
                self.inventories = self.cart?.inventories?.allObjects as? [Inventory]
                self.cartTableView.reloadData()
            }
        } else {
            self.inventories = self.cart?.inventories?.allObjects as? [Inventory]
            self.cartTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.inventories?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cartTableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        cell.inventoryNameLabel.text = self.inventories![indexPath.row].name
        cell.inventoryDateLabel.text = "\(self.inventories![indexPath.row].date!)"
        cell.inventoryAmountLabel.text = self.inventories![indexPath.row].detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

   
}
