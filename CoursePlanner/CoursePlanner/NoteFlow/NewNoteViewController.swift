//
//  NewNoteViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var session: Session!
    var backgroundSession: Session!
    let stack = CoreDataStack.instance

    @IBOutlet weak var noteTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         let sessionObjID = self.session.objectID
        self.backgroundSession = stack.downloadContext.object(with: sessionObjID) as! Session

        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let newNote = Note(context: stack.downloadContext)
        newNote.date = session.date
        newNote.text = self.noteTextField.text
        self.backgroundSession.addToNotes(newNote)
        stack.saveTo(context: stack.downloadContext)
    }
    

}
