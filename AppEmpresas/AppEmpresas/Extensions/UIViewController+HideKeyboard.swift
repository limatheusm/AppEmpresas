//
//  UIViewController+HideKeyboard.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
