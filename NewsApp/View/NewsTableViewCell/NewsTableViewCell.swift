//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var headlinesLabel: UILabel!
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
}
