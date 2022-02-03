//
//  CoreDataServiceManager.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/20/22.
//

import CoreData

class CoreDataServiceManager {
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CacheCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("error")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    func saveContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("error context\(nserror.userInfo), \(nserror.code)")
        }
    }
}
}
