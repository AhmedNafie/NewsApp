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
    @IBOutlet weak var headlinesLabel: UILabel!
    
    override func prepareForReuse() {
        newsImageView.image = UIImage(named: Constants.Assets.placeholder)
    }
}
