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
    
    // MARK: - Properties
    private let dataController =  DataController(modelName: "ArticleModel")

    private init() {
        dataController.load()
    }
    
    // MARK: - Methods
    func loadFromDatabase() -> [Article]? {
        let fetchRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        if let result = try? self.dataController.viewContext.fetch(fetchRequest) {
            return result.map {
                .init(title: $0.title,
                      description: $0.content,
                      urlToImage: nil,
                      imageData: $0.imageData)
            }
        }
        return nil
    }
    
    func saveToDatabase(with articles: [Article]) {
        for article in articles {
            guard let url = URL(string: article.urlToImage ?? "") else { return }
            NewsClient.requestImageFile(url: url) { [weak self] image, error in
                guard let self = self else { return }
                let articleDB = ArticleDB(context: self.dataController.viewContext)
                articleDB.title = article.title
                articleDB.content = article.description
                articleDB.imageData = image?.jpegData(compressionQuality: 1)
                try? self.dataController.viewContext.save()
            }
        }
    }
}
