//
//  HistoryViewController.swift
//  TriviaTime
//
//  Created by Eliel A. Gordon on 11/29/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import RealmSwift
import Realm


/// Displays a history of all answered trivia questions from Realm
class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var triviaItems: [TriviaItem] = []
    let dataSource = TableDatasource(items: [])
    let realm = try! Realm()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func fetchTrivia() -> [TriviaItem] {
        let triviaItems = self.realm.objects(TriviaItem.self)
        let arrayTriviaItems = Array(triviaItems)
        return arrayTriviaItems
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.triviaItems = self.fetchTrivia()
        dataSource.items = self.triviaItems
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "History"
        
        self.navigationController?
            .navigationBar
            .setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30, weight: .black),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        tableView.dataSource = dataSource
        
        dataSource.configureCell = { (tableView, indexPath) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
            
            //TODO: Fill me in with history details
            cell.textLabel?.text = self.triviaItems[indexPath.row].question
            cell.detailTextLabel?.text = "\(self.triviaItems[indexPath.row].correct)"
            return cell
        }
        
        tableView.estimatedRowHeight = 55
    }
    
    
    
}
