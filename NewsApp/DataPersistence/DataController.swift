//
//  DataController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 09/11/2023.
//

import Foundation
import CoreData
import UIKit

class DataController {
    
    let persistenceContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    init(modelName: String) {
        persistenceContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistenceContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}
