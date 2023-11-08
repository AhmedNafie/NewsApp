//
//  UITableView+Extensions.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

extension UITableView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    public func register<T: UITableViewCell>(cell: T.Type) {
        let className = cell.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        return cell
    }
}
