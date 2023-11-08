//
//  UIViewController+showAlert.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 26/04/2022.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: Constants.Strings.okText, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


