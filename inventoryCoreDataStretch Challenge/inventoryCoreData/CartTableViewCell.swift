//
//  CartTableViewCell.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/15/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var inventoryNameLabel: UILabel!
    @IBOutlet weak var inventoryDateLabel: UILabel!
    @IBOutlet weak var inventoryAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
