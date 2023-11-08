//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var headlinesLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var ratingTextField: UITextField!
    var article: Article?
    
    override func viewDidLoad() {
        configureArticle()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let allowedRatings = 1...5
        let rating = Int(ratingTextField.text ?? "0")
        let message = allowedRatings.contains(rating ?? 0) ? Constants.Strings.ratingMessageSucessfull : Constants.Strings.ratingMessageFailed
        presentAlert(title: Constants.Strings.ratingMessageTitle, message: message)
        
    }
    
    func configureArticle() {
        if let url = URL(string: article?.urlToImage ?? "") {
            NewsClient.requestImageFile(url: url) { image, error in
                DispatchQueue.main.async {
                    self.newsImageView.image = image
                }
            }
        }
        
        headlinesLabel.text = article?.title
        contentLabel.text = article?.description
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: Constants.Strings.okText, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

