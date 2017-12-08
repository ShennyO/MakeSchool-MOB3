//
//  ProjectsViewController.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/8/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate {
    var course: Course!
    var projects: [Project]!
    let tableDataSource = TableDatasource(items: [])
    @IBOutlet weak var projectsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.projects = fetchEntities(entity: Project.self, route: Route.project(courseName: self.course.name!))
        projectsTableView.dataSource = tableDataSource
        tableDataSource.items = self.projects
        self.projectsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDataSource.configureCell = { (tableview, index) in
            let cell = tableview.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
            cell.projectNameLabel.text = self.projects[index.row].name
            cell.dueDateLabel.text = self.projects[index.row].dueDate
            return cell
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toNewProject" {
                let newProjectVC = segue.destination as! NewProjectViewController
                newProjectVC.course = self.course
            }
        }
    }
    
  
}
