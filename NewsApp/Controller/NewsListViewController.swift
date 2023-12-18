//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit
protocol NewsList {
    
}
class NewsListViewController: UIViewController, NewsList {
    
    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
     var articles: [Article] = []
    var presenter: NewsPresenter!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsPresenter(view: self)
        setupTableView()
        presenter.fetchArticles()
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
    
    func goToNewsDetailVC(with item: Int) {
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.className) as! NewsDetailViewController
        NewsDetailViewController.article = articles[item]
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
    }
}
