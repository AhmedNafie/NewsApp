//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

protocol NewsDetailView {
    func presentError(with message: String)
}

class NewsDetailViewController: UIViewController {
   
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingTextField: UITextField!
    
    // MARK: - Properties
    var article: Article?
    private var presenter: NewsDetailPresenting!
   
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsDetailPresenter(view: self)
        configureArticle()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        let rating = ratingTextField.text ?? "0"
        presenter.saveButtonTapped(with: rating)
    }
}

// MARK: Private methods
private extension NewsDetailViewController {
    func configureArticle() {
        titleLabel.text = article?.title
        contentLabel.text = article?.description
        
        if let image = DataPersistenceManager.shared.imagesCache[article?.title ?? ""] {
            newsImageView.image = image
        } else {
            if let imagePath = article?.urlToImage {
                guard let url = URL(string: imagePath) else { return }
                NewsClient.requestImageFile(url: url) { [weak self] image, error in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                    DataPersistenceManager.shared.imagesCache[self.article?.title ?? ""] = image
                }
            }
        }
    }
}

extension NewsDetailViewController: NewsDetailView {
}
