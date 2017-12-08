//
//  SessionTableViewCell.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

protocol sessionCellDelegate {
    func sendSession(index: IndexPath)
}
class SessionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sessionLabel: UILabel!
    var indexpath: IndexPath!
    var delegate: sessionCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func noteButtonTapped(_ sender: Any) {
        self.delegate.sendSession(index: self.indexpath)
    }
    
}
