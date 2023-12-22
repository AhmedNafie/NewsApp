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
        newsDetailViewController.article = article
        viewContoller.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
}
