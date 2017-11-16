//
//  Inventory+extension.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/13/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import CoreData

extension Inventory {
    
    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Inventory", in: context)
        self.init(entity: entityDescription!, insertInto: context)
    }
    
}
