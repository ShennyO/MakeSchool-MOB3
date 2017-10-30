//
//  robotTableViewCell.swift
//  AppBundleReader
//
//  Created by Sunny Ouyang on 10/27/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class robotTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personalityLabel: UILabel!
    @IBOutlet weak var phraseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
