//
//  KeyboardStateListener.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

protocol KeyboardStateListenerDelegate: class {
    func keyboardWillShow(_ keyboardStateListener: KeyboardStateListener,
                          keyboardHeight: CGFloat, duration: Double, animationCurve: UIView.AnimationOptions)
    func keyboardWillHide(_ keyboardStateListener: KeyboardStateListener,
                          keyboardHeight: CGFloat, duration: Double, animationCurve: UIView.AnimationOptions)
}

class KeyboardStateListener: NSObject {
    private(set) var isVisible = false
    
    weak var delegate: KeyboardStateListenerDelegate?
    
    init(delegate: KeyboardStateListenerDelegate) {
        super.init()
        self.delegate = delegate
        NotificationCenter.default.addObserver(self, selector: #selector(self.willShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func willShow(_ notification: Notification) {
        guard !self.isVisible else {
            return
        }
        
        self.isVisible = true
        
        self.delegate?.keyboardWillShow(self,
                                        keyboardHeight: self.getKeyboardHeight(from: notification),
                                        duration: self.getKeyboardAnimationDuration(from: notification),
                                        animationCurve: self.getKeyboardAnimationCurve(from: notification))
    }
    
    @objc private func willHide(_ notification: Notification) {
        guard self.isVisible else {
            return
        }
        
        self.isVisible = false
        self.delegate?.keyboardWillHide(self,
                                        keyboardHeight: self.getKeyboardHeight(from: notification),
                                        duration: self.getKeyboardAnimationDuration(from: notification),
                                        animationCurve: self.getKeyboardAnimationCurve(from: notification))
    }
    
    // MARK: - Helpers
    
    private func getKeyboardHeight(from notification: Notification) -> CGFloat {
        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height ?? 300
    }
    
    private func getKeyboardAnimationDuration(from notification: Notification) -> Double {
        (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
    }
    
    private func getKeyboardAnimationCurve(from notification: Notification) -> UIView.AnimationOptions {
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return .curveEaseOut
        }
        
        return UIView.AnimationOptions(rawValue: curve.uintValue)
    }
}

