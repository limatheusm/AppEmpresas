//
//  UIView+Animation.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

extension UIView {
    func showAnimated() {
        UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseOut) {
            self.alpha = 1
        }
    }
    
    func hideAnimated() {
        UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseOut) {
            self.alpha = 0
        }
    }
}
