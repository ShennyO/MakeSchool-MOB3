//
//  NewProjectViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/8/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {
    var course: Course!
    let stack = CoreDataStack.instance
    @IBOutlet weak var projectNameLabel: UITextField!
    @IBOutlet weak var dueDateLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let newProj = Project(context: stack.downloadContext)
        newProj.completed = false
        newProj.courseName = self.course.name
        newProj.name = self.projectNameLabel.text
        newProj.dueDate = self.dueDateLabel.text
        stack.saveTo(context: stack.downloadContext)
    }
    
}
