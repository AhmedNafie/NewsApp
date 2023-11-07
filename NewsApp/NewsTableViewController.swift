//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 07/11/2023.
//

import UIKit

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = "Testing"
        return cell
    }
    
}

