//
//  CoreDataStack.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/12/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CleanEats")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}

