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
        fetchNews()
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.totalResults ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = news?.articles[indexPath.row].title
        if let url = news?.articles[indexPath.row].urlToImage {
            let URL = URL(string: url)
            NewsClient.requestImageFile(url: URL!) { image, error in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NewsDetailViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        navigationController?.pushViewController(NewsDetailViewController, animated: true)
    }
}

private extension NewsListViewController {
    
    func fetchNews() {
        NewsClient.requestNews(url: NewsClient.endPoints.news.url) { response, error in
            self.news = response
            self.newsTableView.reloadData()
        }
    }
}
