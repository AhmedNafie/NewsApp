//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 18/12/2023.
//

import Foundation

protocol NewsPresenting {
    var articles: [Article] { get }
    func viewDidLoad()
    func numberOfRows() -> Int
    func cellForRowAt(_ indexPathRow: Int) -> Article
}

class NewsPresenter {
    private var view: NewsListView!
    var articles: [Article] = []
    
    init(view: NewsListView) {
        self.view = view
    }

    func fetchFromNetwork() {
        view.startLoading()
        guard let url = NewsClient.endPoints.news.url else { return }
        NewsClient.requestNews(url: url) { [weak self] response, error in
            guard let self = self else { return }
            self.view.stopLoading()
            if let error = error {
                self.view.presentError(with: error.localizedDescription)
                return
            }
            if let articles = response?.articles {
                self.articles = articles
                DataPersistenceManager.shared.saveToDatabase(with: articles)
                self.view.updateUI()
            }
        }
    }
    
    func fetchFromStore() {
        if let articles = DataPersistenceManager.shared.loadFromDatabase(), !articles.isEmpty {
            self.articles = articles
            view.updateUI()
        } else {
            view.presentError(with: Constants.Strings.databaseFailure)
        }
    }
}

// MARK: NewsPresenting methods
extension NewsPresenter: NewsPresenting {
    
    func numberOfRows() -> Int {
        articles.count
    }
    
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            fetchFromNetwork()
            view.setTitle(Constants.Strings.onlineTitle)
        } else {
            fetchFromStore()
            view.setTitle(Constants.Strings.offlineTitle)
        }
    }
    
    func cellForRowAt(_ indexPathRow: Int) -> Article {
        articles[indexPathRow]
    }
}
