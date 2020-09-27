//
//  KeyboardStateListener.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

protocol KeyboardStateListenerDelegate: class {
    func keyboardWillShow(_ keyboardStateListener: KeyboardStateListener, notification: Notification)
    func keyboardWillHide(_ keyboardStateListener: KeyboardStateListener, notification: Notification)
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
        self.delegate?.keyboardWillShow(self, notification: notification)
    }
    
    @objc private func willHide(_ notification: Notification) {
        guard self.isVisible else {
            return
        }
        
        self.isVisible = false
        self.delegate?.keyboardWillHide(self, notification: notification)
    }
}

