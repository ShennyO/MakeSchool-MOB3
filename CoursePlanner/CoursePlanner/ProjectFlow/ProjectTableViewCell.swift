//
//  ProjectTableViewCell.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/8/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
protocol projectCellDelegate {
    func sendProject(index: IndexPath)
}
class ProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    var delegate: projectCellDelegate!
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func completedButtonTapped(_ sender: Any) {
        //in here I want to send the project out to the VC, and in the VC, I will change the completed to True, and resave 
        self.delegate.sendProject(index: self.index)
    }
    

}
