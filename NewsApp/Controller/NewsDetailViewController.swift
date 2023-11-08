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
    @IBOutlet weak var newsDetailTextView: UITextView!
    
    var article: Article?
    
    override func viewDidLoad() {
        configureArticle()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
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
        newsDetailTextView.text = article?.content
    }
}

