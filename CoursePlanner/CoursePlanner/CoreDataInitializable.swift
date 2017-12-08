//
//  CoreDataInitializable.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/5/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataInitializable {
    init(context: NSManagedObjectContext)
}

extension CoreDataInitializable where Self: NSManagedObject {
    init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entity(
            forEntityName: NSManagedObject.entityName(), in:
            context
            )!
        
        self.init(entity: entityDescription, insertInto: context)
    }
}

extension NSManagedObject {
    class func entityName() -> String {
        let fullClassName = String(describing: self)
        let nameComponents = fullClassName.split(separator: ".")
        return String(describing: nameComponents.last)
    }
}

extension Session: CoreDataInitializable {
    
}

extension Course: CoreDataInitializable {
    
}

extension Project: CoreDataInitializable {
    
}

extension Note: CoreDataInitializable {
    
}
