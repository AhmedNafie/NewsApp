//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 125

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        newsImageView.image = UIImage(named: Constants.Assets.placeholder)
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        if let imagePath = article.urlToImage {
            guard let url = URL(string: imagePath) else { return }
            NewsClient.requestImageFile(url: url) { [weak self] image, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.newsImageView.image = image
                }
            }
        } else {
            if let imageData = article.imageData {
                newsImageView.image = UIImage(data: imageData)
            }
        }
    }
}
