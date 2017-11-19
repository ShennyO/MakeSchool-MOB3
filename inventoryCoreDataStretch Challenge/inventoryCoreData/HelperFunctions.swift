//
//  HelperFunctions.swift
//  inventoryCoreData
//
//  Created by Sunny Ouyang on 11/17/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import CoreData


//enum entityType {
//    case Inventory
//    case Cart
//
//    func getEntityType() -> NSFetchRequestResultType {
//        switch self {
//        case .Cart:
//            return Cart
//        default:
//            <#code#>
//        }
//    }
//
//
//
//}

func fetchCartFromCoreData(entityName: String) -> [NSManagedObject]? {
    let coreData = CoreDataStack.instance
    
    let fetchRequest = NSFetchRequest<Cart>(entityName: entityName)
    do {
        let result = try coreData.viewContext.fetch(fetchRequest)
        return result
    } catch let error {
        print(error)
    }
    return nil
}


func fetchInventoryFromCoreData(entityName: String) -> [NSManagedObject]? {
    let coreData = CoreDataStack.instance
    
    let fetchRequest = NSFetchRequest<Inventory>(entityName: entityName)
    do {
        let result = try coreData.viewContext.fetch(fetchRequest)
        return result
    } catch let error {
        print(error)
    }
    return nil
}



