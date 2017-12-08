//
//  TableViewDataSource.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/7/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import UIKit

typealias TableCellCallback = (UITableView, IndexPath) -> UITableViewCell

class TableDatasource<Item>: NSObject, UITableViewDataSource {
    var items: [Item]
    
    var configureCell: TableCellCallback?
    
    init(items: [Item]) {
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let configureCell = configureCell else {
            precondition(false, "You did pass a configuration closure to configureCell, you must do so")
        }
        //We're going to set up the cell on another view controller, we'll set up the tableview data source, and type of cell in the viewdidload of the VC.
        return configureCell(tableView, indexPath)
    }
}
