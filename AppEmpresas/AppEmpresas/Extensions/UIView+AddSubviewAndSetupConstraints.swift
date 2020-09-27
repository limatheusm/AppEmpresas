//
//  UIView+AddSubviewAndSetupConstraints.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

extension UIView {
    func addSubviewAndSetupConstraints(_ subview: UIView?) {
        guard let subview = subview else {
            return
        }
        
        self.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
