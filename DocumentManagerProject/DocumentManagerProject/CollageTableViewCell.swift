//
//  CollageTableViewCell.swift
//  DocumentManagerProject
//
//  Created by Sunny Ouyang on 11/1/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit



class CollageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    @IBOutlet weak var collageName: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

    
}
