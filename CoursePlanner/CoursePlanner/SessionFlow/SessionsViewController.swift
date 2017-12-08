//
//  SessionsViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController, UITableViewDelegate, sessionCellDelegate {
    
    

    @IBOutlet weak var sessionsTableView: UITableView!
    var course: Course!
    var sessions: [Session] = []
    let datasource = TableDatasource(items: [])
    var sessionToPass: Session!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource.configureCell = { (tableView, indexPath) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell") as! SessionTableViewCell
            cell.sessionLabel.text = self.sessions[indexPath.row].date
            cell.indexpath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sessions = fetchEntities(entity: Session.self, route: Route.session(courseName: self.course.name!))!
        self.sessionsTableView.dataSource = datasource
        datasource.items = self.sessions
        self.sessionsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func sendSession(index: IndexPath) {
        self.sessionToPass = self.sessions[index.row]
        self.performSegue(withIdentifier: "toNotes", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toNewSession" {
                let newSessionVC = segue.destination as! NewSessionViewController
                newSessionVC.course = self.course
            } else if identifier == "toNotes" {
                let notesVC = segue.destination as! NotesViewController
                notesVC.sessionDate = self.sessionToPass.date
            }
        }
    }
    
    
  
}
