//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
        
    // MARK: - Properties
    static let cellHeight: CGFloat = 125

    // MARK: - Methods
    override func prepareForReuse() {
        newsImageView.image = UIImage(named: Constants.Assets.placeholder)
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        if let image = DataPersistenceManager.shared.imagesCache[article.title ?? ""] {
            newsImageView.image = image
        } else {
            if let imagePath = article.urlToImage {
                guard let url = URL(string: imagePath) else { return }
                NewsClient.requestImageFile(url: url) { [weak self] image, error in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                    DataPersistenceManager.shared.imagesCache[article.title ?? ""] = image
                }
            }
        }
    }
}
