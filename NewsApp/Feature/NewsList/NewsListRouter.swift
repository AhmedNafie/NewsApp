//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 22/12/2023.
//

import UIKit

protocol NewsListRouting {
    func goToNewsDetailVC(with article: Article)
}

class NewsListRouter: NewsListRouting {
    let viewContoller: UIViewController!
    init(viewContoller: UIViewController) {
        self.viewContoller = viewContoller
    }
    
    func goToNewsDetailVC(with article: Article) {
        let newsDetailViewController = viewContoller.storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.className) as! NewsDetailViewController
        let presenter = NewsDetailPresenter(view: newsDetailViewController, article: article)
        newsDetailViewController.presenter = presenter
        viewContoller.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
}
