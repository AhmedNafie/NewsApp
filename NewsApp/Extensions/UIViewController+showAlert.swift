//
//  UIViewController+showAlert.swift
//  NewsApp
//
//  Created by Ahmed Nafie on 08/11/2023.
//

import UIKit

extension UIViewController {
    func presentError(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: Constants.Strings.okText, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


