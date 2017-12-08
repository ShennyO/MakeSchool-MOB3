//
//  NotesViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var notesTableView: UITableView!
    var notes: [Note] = []
    var sessionDate: String!
    var session: Session!
    var course: Course!
    let datasource = TableDatasource(items: [])
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sessionPredicate = NSPredicate(format: "date == %@", self.sessionDate)
        self.session = customFetchEntity(entity: Session.self, predicate: sessionPredicate)
        self.notes = session.notes?.allObjects as! [Note]
        self.notesTableView.dataSource = datasource
        datasource.items = self.notes
        DispatchQueue.main.async {
            self.notesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        datasource.configureCell = { (tableview, indexpath) -> UITableViewCell in
            let cell = self.notesTableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteTableViewCell
            cell.noteDateLabel.text = self.notes[indexpath.row].date
            cell.noteTextField.text = self.notes[indexpath.row].text
            return cell
        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let identifier = segue.identifier {
                if identifier == "toNewNote" {
                    let newNoteVC = segue.destination as! NewNoteViewController
                    newNoteVC.session = self.session
                }
            }
        }
    

}
