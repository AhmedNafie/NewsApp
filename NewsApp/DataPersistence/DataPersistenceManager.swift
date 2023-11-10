//
//  DataPersistenceManager.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 09/11/2023.
//

import CoreData
import UIKit

class DataPersistenceManager {
    
    // MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    // MARK: - Properties
    private let dataController =  DataController(modelName: "ArticleModel")
    var imagesCache: [String: UIImage] = [:]
    
    private init() {
        dataController.load()
    }
    
    // MARK: - Methods
    func loadFromDatabase() -> [Article]? {
        let fetchRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        if let result = try? self.dataController.viewContext.fetch(fetchRequest) {
            return result.map {
                if let imageData = $0.imageData {
                    imagesCache[$0.title!] = UIImage(data: imageData)
                }
                return .init(title: $0.title,
                             description: $0.content,
                             urlToImage: nil)
            }
        }
        return nil
    }
    
    func saveToDatabase(with articles: [Article]) {
        clearDatabase()
        for article in articles {
            let articleDB = ArticleDB(context: self.dataController.viewContext)
            articleDB.title = article.title
            articleDB.content = article.description
            guard let url = URL(string: article.urlToImage ?? "") else {
                try? self.dataController.viewContext.save()
                continue
            }
            NewsClient.requestImageFile(url: url) { [weak self] image, error in
                guard let self = self else { return }
                articleDB.imageData = image?.jpegData(compressionQuality: 1)
                try? self.dataController.viewContext.save()
            }
        }
    }
    
    private func clearDatabase() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleDB")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try dataController.viewContext.execute(deleteRequest)
        } catch {
            print(error)
        }
    }
}
