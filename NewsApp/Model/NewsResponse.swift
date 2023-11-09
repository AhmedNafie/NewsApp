//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
    let imageData: Data?
}
