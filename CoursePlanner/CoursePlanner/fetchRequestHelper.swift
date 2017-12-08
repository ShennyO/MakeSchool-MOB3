//
//  fetchRequestHelper.swift
//  CoursePlanner
//
//  Created by Sunny Ouyang on 12/5/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import CoreData



enum Route {
    case course
    case session(courseName: String)
    case note(sessionName: String)
    case project(courseName: String)
    
    func predicate() -> NSPredicate? {
        switch self {
        case let .session(courseName):
            return NSPredicate(format: "courseName == %@", courseName)
        case let .note(sessionName):
            return NSPredicate(format: "Session == %@", sessionName)
        case let .project(courseName):
            return NSPredicate(format: "courseName == %@", courseName)
        default:
            return nil
        }
    }
}

func customFetchEntity<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate) -> T? {
    var results: [T]?
    let stack = CoreDataStack.instance
    
    let fetchReq: NSFetchRequest<T> = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    fetchReq.predicate = predicate
    do {
        results = try stack.viewContext.fetch(fetchReq)
    } catch  {
        assert(false, error.localizedDescription)
    }
    
    
    return results?.first
}

func fetchEntities<T: NSManagedObject>(entity: T.Type, route: Route) -> [T]? {
    var results: [T]?
    let stack = CoreDataStack.instance
    
    let fetchReq: NSFetchRequest<T> = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    fetchReq.predicate = route.predicate()
    do {
        results = try stack.viewContext.fetch(fetchReq)
    } catch  {
        assert(false, error.localizedDescription)
    }
   
    
    return results
}
