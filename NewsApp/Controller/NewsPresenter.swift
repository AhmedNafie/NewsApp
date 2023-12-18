//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 18/12/2023.
//

import Foundation

class NewsPresenter {
    var view: NewsListViewController!
    
    init(view: NewsListViewController) {
        self.view = view
    }
    
    func fetchArticles() {
        if Reachability.isConnectedToNetwork() {
            fetchFromNetwork()
            view.title = Constants.Strings.onlineTitle
        } else {
            fetchFromStore()
            view.title = Constants.Strings.offlineTitle
        }
    }
    
    func fetchFromNetwork() {
        view.activityIndicator.startAnimating()
        guard let url = NewsClient.endPoints.news.url else { return }
        NewsClient.requestNews(url: url) { [weak self] response, error in
            guard let self = self else { return }
            self.view.activityIndicator.stopAnimating()
            if let error = error {
                self.view.showAlert(with: error.localizedDescription)
                return
            }
            if let articles = response?.articles {
                self.view.articles = articles
                DataPersistenceManager.shared.saveToDatabase(with: articles)
                self.view.newsTableView.reloadData()
            }
        }
    }
    
    func fetchFromStore() {
        if let articles = DataPersistenceManager.shared.loadFromDatabase(), !articles.isEmpty {
            view.articles = articles
            view.newsTableView.reloadData()
        } else {
            view.showAlert(with: Constants.Strings.databaseFailure)
        }
    }
}
