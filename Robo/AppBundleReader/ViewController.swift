//
//  ViewController.swift
//  AppBundleReader
//
//  Created by Eliel A. Gordon on 10/26/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    
    var robots: [Robot] = []
    
    @IBOutlet weak var robotTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "robo-profiles", ofType: ".json")
        let url = URL(fileURLWithPath: path!)
        
        if let path = path {
             print(path)
            
             let data = try? Data(contentsOf: url)
            
            self.robots = try! JSONDecoder().decode([Robot].self, from: data!)
            
            print(self.robots[0].name)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.robots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = robotTableView.dequeueReusableCell(withIdentifier: "robotCell") as! robotTableViewCell
        cell.nameLabel.text = self.robots[indexPath.row].name
        cell.personalityLabel.text = self.robots[indexPath.row].personality
        cell.phraseLabel.text = self.robots[indexPath.row].phrase
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

