//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 18/12/2023.
//

import Foundation

protocol NewsPresenting {
    func viewDidLoad()
    func numberOfRows() -> Int
    func cellForRowAt(_ row: Int) -> Article
    func didSelectRowAt(_ row: Int)
}

class NewsPresenter {
    private var view: NewsListView
    private var router: NewsListRouting
    var articles: [Article] = []
    
    init(view: NewsListView, router: NewsListRouting) {
        self.view = view
        self.router = router
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
            view.setTitle(with: Constants.Strings.onlineTitle)
        } else {
            fetchFromStore()
            view.setTitle(with: Constants.Strings.offlineTitle)
        }
    }
    
    func cellForRowAt(_ indexPathRow: Int) -> Article {
        articles[indexPathRow]
    }
    
    func didSelectRowAt(_ row: Int) {
        let article = articles[row]
        router.goToNewsDetailVC(with: article)
    }
}
