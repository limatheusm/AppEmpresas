//
//  UIViewController+Alert.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 28/09/20.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(message: String, title: String = "", okAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
