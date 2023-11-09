//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit
import CoreData

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var news: NewsResponse?
    var offlineAritcles: [Articles] = []
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchNews()
        fetchStore()
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.articles.count ?? offlineAritcles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: NewsTableViewCell.self, for: indexPath)
        if Reachability.isConnectedToNetwork() {
            cell.configure(title: news?.articles[indexPath.row].title,
                           imagePath: news?.articles[indexPath.row].urlToImage)
            saveToStore(with: indexPath.row)
            return cell
        }
        cell.configure(title: offlineAritcles[indexPath.row].articleTitle,
                       imagePath: "")
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNewsDetailVC(with: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NewsTableViewCell.cellHeight
    }
}

private extension NewsListViewController {
    func setupTableView() {
        newsTableView.register(cell: NewsTableViewCell.self)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func fetchNews() {
        activityIndicator.startAnimating()
        guard let url = NewsClient.endPoints.news.url else { return }
        NewsClient.requestNews(url: url) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(with: error.localizedDescription)
                return
            }
            self.activityIndicator.stopAnimating()
            self.news = response
            self.newsTableView.reloadData()
        }
    }
    
    func goToNewsDetailVC(with item: Int) {
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.className) as! NewsDetailViewController
        NewsDetailViewController.article = news?.articles[item]
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
    }
    
    func saveToStore(with item: Int) {
        let Articles = Articles(context: dataController.viewContext)
        Articles.articleTitle = news?.articles[item].title
        Articles.articleDescription = news?.articles[item].description
        try? dataController.viewContext.save()
        //        print(Articles.articleTitle)
    }
    
    func fetchStore() {
        let fetchRequest: NSFetchRequest<Articles> = Articles.fetchRequest()
        if let result = try? self.dataController.viewContext.fetch(fetchRequest) {
            offlineAritcles = result
            print(offlineAritcles[1].articleTitle)
            newsTableView.reloadData()
        }
    }
}
