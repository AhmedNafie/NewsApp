//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    private var news: NewsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsClient.requestNews(url: NewsClient.endPoints.news.url) { response, error in
            self.news = response
            self.newsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.totalResults ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = news?.articles[indexPath.row].title
        return cell
    }
}

