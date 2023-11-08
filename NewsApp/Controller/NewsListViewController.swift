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
        return news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
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
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        NewsDetailViewController.article = news?.articles[indexPath.row]
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

private extension NewsListViewController {
    func setupTableView() {
        newsTableView.register(.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
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
