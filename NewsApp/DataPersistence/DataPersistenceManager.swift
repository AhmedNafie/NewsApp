//
//  DataPersistenceManager.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 09/11/2023.
//

import CoreData

class DataPersistenceManager {
    
    // MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    private init() {
        dataController.load()
    }
        
    private let dataController =  DataController(modelName: "ArticleModel")
    
    func loadFromDatabase() -> [Article]? {
        let fetchRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        if let result = try? self.dataController.viewContext.fetch(fetchRequest) {
            return result.map {
                .init(title: $0.title,
                      description: $0.content,
                      urlToImage: nil)
            }
        }
        return nil
    }
    
    func saveToDatabase(with articles: [Article]) {
        for article in articles {
            let articleDB = ArticleDB(context: dataController.viewContext)
            articleDB.title = article.title
            articleDB.content = article.description
            try? dataController.viewContext.save()
        }
    }
}
