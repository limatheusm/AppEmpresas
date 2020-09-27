//
//  PasswordTextInputView.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

class PasswordTextInputView: TextInputView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel?.text = "Password"
        self.textField?.isSecureTextEntry = true
    }
    
    // MARK: - User Actions
    
    override func onEyeButtonTap(_ sender: Any) {
        super.onEyeButtonTap(sender)
        
        self.textField?.isSecureTextEntry.toggle()
    }
    
    // MARK: - UI Updates
    
    override func updateIcon() {
        if case .error = self.state {
            self.iconButton?.setImage(kErrorIcon, for: .normal)
            self.iconButton?.isUserInteractionEnabled = false
        } else {
            self.iconButton?.setImage(kEyeIcon, for: .normal)
            self.iconButton?.isUserInteractionEnabled = true
        }
    }
}
