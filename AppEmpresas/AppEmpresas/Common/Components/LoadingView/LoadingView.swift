//
//  LoadingView.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

class LoadingView: UIView {
    private let kDefaultAnimationDuration: TimeInterval = 0.3
    private let kRotationAnimationDuration: TimeInterval = 1.5

    var loadingIndicator: LoadingIndicator?
    
    func show(in view: UIView) {
        self.backgroundColor = .loadingBackground
        view.addSubviewAndSetupConstraints(self)
        self.loadingIndicator = LoadingIndicator()
        
        if let loadingIndicator = self.loadingIndicator {
            self.addSubviewAndSetupConstraints(loadingIndicator)
        }
        
        self.alpha = 0
        
        UIView.animate(withDuration: kDefaultAnimationDuration, delay: .zero, options: .curveEaseOut) {
            self.alpha = 1
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: kDefaultAnimationDuration, delay: .zero, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.loadingIndicator?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
