//
//  NewCourseViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class NewCourseViewController: UIViewController {
    @IBOutlet weak var newCourseTextField: UITextField!
    @IBOutlet weak var newCourseMeetingTime: UITextField!
    let stack = CoreDataStack.instance
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let courseName = newCourseTextField.text else {return}
        guard let meetingTime = newCourseMeetingTime.text else {return}
        let newCourse = Course(context: stack.downloadContext)
        newCourse.name = courseName
        newCourse.times = meetingTime
        stack.saveTo(context: stack.downloadContext)
    }
    
    
}
