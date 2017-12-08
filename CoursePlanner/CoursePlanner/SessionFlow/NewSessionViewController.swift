//
//  NewSessionViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class NewSessionViewController: UIViewController {
    @IBOutlet weak var sessionTimeTextField: UITextField!
    let stack = CoreDataStack.instance
    var course: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func addButtonTapped(_ sender: Any) {
        let newSession = Session(context: stack.downloadContext)
        newSession.courseName = self.course.name
        newSession.date = self.sessionTimeTextField.text
        stack.saveTo(context: stack.downloadContext)
    }
    

}
