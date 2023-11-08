//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    let allowedRatings = ["1", "2", "3", "4", "5"]
    @IBOutlet weak var headlinesLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var ratingTextField: UITextField!
    var article: Article?
    
    override func viewDidLoad() {
        configureArticle()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        for rating in allowedRatings {
            if ratingTextField.text == rating  {
                presentAlert(title: "Rating", message: "You have rated the article successfully")
            } else {
                presentAlert(title: "Rating", message: "Please choose a number from 1 to 5")
            }
        }
        
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
        let action = UIAlertAction.init(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

