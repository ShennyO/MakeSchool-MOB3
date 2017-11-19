//
//  InventoryTableViewCell.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/13/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

protocol inventoryDelegate {
    func sendInventory(inventoryIndexPath: IndexPath)
}

class InventoryTableViewCell: UITableViewCell {
    
    var delegate: inventoryDelegate?
    var indexPath: IndexPath?

    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    @IBAction func addToCartTapped(_ sender: Any) {
        delegate?.sendInventory(inventoryIndexPath: self.indexPath!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
