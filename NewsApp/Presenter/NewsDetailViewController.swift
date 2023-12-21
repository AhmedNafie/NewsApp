//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
   
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingTextField: UITextField!
    
    // MARK: - Properties
    var article: Article?
   
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureArticle()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        validateRating()
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
    
    func validateRating() {
        let allowedRatings = 1...5
        let rating = Int(ratingTextField.text ?? "0")
        let message = allowedRatings.contains(rating ?? 0) ? Constants.Strings.ratingMessageSucessful : Constants.Strings.ratingMessageFailed
        presentError(with: message)
    }
}
