//
//  DataController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 09/11/2023.
//

import CoreData

class DataController {
    // MARK: - Properties
    let persistenceContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    init(modelName: String) {
        persistenceContainer = NSPersistentContainer(name: modelName)
    }
    
    // MARK: - Methods
    func load() {
        persistenceContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}
