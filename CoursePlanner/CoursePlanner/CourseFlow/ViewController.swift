//
//  ViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/5/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, courseCellDelegate {
    

    var courses: [Course] = []
    var stack = CoreDataStack.instance
    let dataSource = TableDatasource(items: [])
    var courseToSend: Course!
    
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up our cell
        dataSource.configureCell = { (tableView, indexPath) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! CourseTableViewCell
            cell.courseNameLabel.text = self.courses[indexPath.row].name
            cell.meetingTimeLabel.text = self.courses[indexPath.row].times
            cell.index = indexPath
            cell.delegate = self
            return cell
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.courses = fetchEntities(entity: Course.self, route: Route.course)!
        self.courseTableView.dataSource = dataSource
        dataSource.items = self.courses
        self.courseTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func sendCourse(index: IndexPath) {
        self.courseToSend = self.courses[index.row]
        self.performSegue(withIdentifier: "toProjects", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toSessions" {
                let sessionsVC = segue.destination as! SessionsViewController
                let indexPath = self.courseTableView.indexPathForSelectedRow!
                sessionsVC.course = self.courses[indexPath.row]
            } else if identifier == "toProjects" {
                let projectsVC = segue.destination as! ProjectsViewController
                projectsVC.course = self.courseToSend
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

