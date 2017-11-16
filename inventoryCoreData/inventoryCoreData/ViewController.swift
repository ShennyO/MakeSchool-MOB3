//
//  ViewController.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/13/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var inventoryTableView: UITableView!
    
    var inventoryList: [Inventory] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    func fetchFromCoreData() {
        let coreData = CoreDataStack.instance
        
        let fetchRequest = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let result = try coreData.viewContext.fetch(fetchRequest)
            self.inventoryList = result
            self.inventoryTableView.reloadData()
        } catch let error {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       fetchFromCoreData()
        
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
            coreData.viewContext.delete(inventory)
            coreData.saveTo(context: coreData.viewContext)
            fetchFromCoreData()
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
    

}

