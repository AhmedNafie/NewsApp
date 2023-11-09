//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

class NewsListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var articles: [Article] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchArticles()
    }
}

// MARK: UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: NewsTableViewCell.self, for: indexPath)
        cell.configure(with: articles[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNewsDetailVC(with: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NewsTableViewCell.cellHeight
    }
}

// MARK: Private methods
private extension NewsListViewController {
    func setupTableView() {
        newsTableView.register(cell: NewsTableViewCell.self)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func fetchArticles() {
        if Reachability.isConnectedToNetwork() {
            fetchFromNetwork()
            title = Constants.Strings.onlineTitle
        } else {
            fetchFromStore()
            title = Constants.Strings.offlineTitle
        }
    }
    
    func fetchFromNetwork() {
        activityIndicator.startAnimating()
        guard let url = NewsClient.endPoints.news.url else { return }
        NewsClient.requestNews(url: url) { [weak self] response, error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.showAlert(with: error.localizedDescription)
                return
            }
            if let articles = response?.articles {
                self.articles = articles
                DataPersistenceManager.shared.saveToDatabase(with: articles)
                self.newsTableView.reloadData()
            }
        }
    }
    
    
    func fetchFromStore() {
        if let articles = DataPersistenceManager.shared.loadFromDatabase(), !articles.isEmpty {
            self.articles = articles
            newsTableView.reloadData()
        } else {
            showAlert(with: Constants.Strings.databaseFailure)
        }
    }
    
    func goToNewsDetailVC(with item: Int) {
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.className) as! NewsDetailViewController
        NewsDetailViewController.article = articles[item]
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
    }
}
