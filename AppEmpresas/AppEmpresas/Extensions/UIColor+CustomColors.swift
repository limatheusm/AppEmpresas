//
//  UIColor+CustomColors.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

extension UIColor {
    static var primary: UIColor {
        UIColor(red: 224/255.0, green: 30/255.0, blue: 104/255.0, alpha: 1)
    }
    
    static var error: UIColor {
        UIColor(red: 224/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    }
    
    static var loadingBackground: UIColor {
        UIColor(white: 0, alpha: 0.4)
    }
}
