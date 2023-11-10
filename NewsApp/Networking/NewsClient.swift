//
//  NewsClient.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

class NewsClient {
    
    enum endPoints: String {
        case news = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ab7aad6758e64293ab42ab229e21ac9f"
        
        var url: URL? {
            return URL(string: self.rawValue)
        }
    }
    
    // MARK: - Methods
    class func requestNews(url: URL, completionHandler: @escaping (NewsResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let newsData = try? decoder.decode(NewsResponse.self, from: data)
            
            DispatchQueue.main.async {
                completionHandler(newsData, nil)
            }
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let imageData = UIImage(data: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
}
