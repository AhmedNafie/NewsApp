//
//  NewsDetailPresenter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 22/12/2023.
//

import Foundation
import UIKit

protocol NewsDetailPresenting {
    func saveButtonTapped(with rating: String)
    func viewDidLoad()
}

class NewsDetailPresenter: NewsDetailPresenting {

    private var article: Article

    private var view: NewsDetailView
    
    init(view: NewsDetailView, article: Article) {
        self.view = view
        self.article = article
    }
    
    func viewDidLoad() {
        view.setArticle(article: article)
    }
    
    func saveButtonTapped(with rating: String) {
        let allowedRatings = 1...5
        let rating = Int(rating)
        let message = allowedRatings.contains(rating ?? 0) ? Constants.Strings.ratingMessageSucessful : Constants.Strings.ratingMessageFailed
        view.presentError(with: message)
    }
}
