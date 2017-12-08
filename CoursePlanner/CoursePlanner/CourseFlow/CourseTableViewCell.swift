//
//  CourseTableViewCell.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
protocol courseCellDelegate {
    func sendCourse(index: IndexPath)
}
class CourseTableViewCell: UITableViewCell {
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var meetingTimeLabel: UILabel!
    var delegate: courseCellDelegate?
    var index: IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func projectsButtonTapped(_ sender: Any) {
        self.delegate?.sendCourse(index: self.index)
    }
    
}
