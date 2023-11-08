//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    private var news: NewsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchNews()
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: NewsTableViewCell.self, for: indexPath)
        cell.newsImageView.image = UIImage(named: "newsPlaceHolder")
        cell.headlinesLabel.text = news?.articles[indexPath.row].title
        if let url = news?.articles[indexPath.row].urlToImage {
            let URL = URL(string: url)
            NewsClient.requestImageFile(url: URL!) { image, error in
                DispatchQueue.main.async {
                    cell.newsImageView.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.className) as! NewsDetailViewController
        NewsDetailViewController.article = news?.articles[indexPath.row]
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
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
        NewsClient.requestNews(url: NewsClient.endPoints.news.url) { response, error in
            self.news = response
            self.newsTableView.reloadData()
        }
    }
}
