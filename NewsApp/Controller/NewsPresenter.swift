//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 18/12/2023.
//

import Foundation

protocol newsPresentation {
   func fetchArticles()
}

class NewsPresenter: newsPresentation {
    var view: NewsList!
    
    init(view: NewsList) {
        self.view = view
    }
    
    func fetchArticles() {
        if Reachability.isConnectedToNetwork() {
            fetchFromNetwork()
            view.setTitle(_title: Constants.Strings.onlineTitle)
        } else {
            fetchFromStore()
            view.setTitle(_title: Constants.Strings.offlineTitle)
        }
    }
    
    func fetchFromNetwork() {
        view.startAnimating()
        guard let url = NewsClient.endPoints.news.url else { return }
        NewsClient.requestNews(url: url) { [weak self] response, error in
            guard let self = self else { return }
            self.view.stopAnimating()
            if let error = error {
                self.view.showAlert(with: error.localizedDescription)
                return
            }
            if let articles = response?.articles {
                self.view.articles = articles
                DataPersistenceManager.shared.saveToDatabase(with: articles)
                self.view.updateUI()
            }
        }
    }
    
    func fetchFromStore() {
        if let articles = DataPersistenceManager.shared.loadFromDatabase(), !articles.isEmpty {
            view.articles = articles
            view.updateUI()
        } else {
            view.showAlert(with: Constants.Strings.databaseFailure)
        }
    }
}
