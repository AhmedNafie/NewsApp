//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

protocol NewsListView {
    func setTitle(with title: String)
    func startLoading()
    func stopLoading()
    func presentError(with message: String)
    func updateUI()
}

class NewsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var presenter: NewsPresenting!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = NewsListRouter(viewContoller: self)
        presenter = NewsPresenter(view: self, router: router)
        setupTableView()
        presenter.viewDidLoad()
    }
}
// MARK: NewsListView
extension NewsListViewController: NewsListView {
    
    func setTitle(with title: String) {
        self.title = title
    }
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateUI() {
        newsTableView.reloadData()
    }
    
}

// MARK: UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: NewsTableViewCell.self, for: indexPath)
        cell.configure(with: presenter.cellForRowAt(indexPath.row))
        return cell
    }
}

// MARK: UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath.row)
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
}
