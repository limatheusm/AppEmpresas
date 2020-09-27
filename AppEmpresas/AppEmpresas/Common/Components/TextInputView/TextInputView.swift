//
//  TextInputView.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

enum TextInputViewState {
    case normal
    case error
}

protocol TextInputViewDelegate: class {
    func textInputViewDidChange(_ textInputView: TextInputView)
}

class TextInputView: UIView {
    let kEyeIcon = UIImage(named: "ic_eye")
    let kErrorIcon = UIImage(named: "ic_error")
    
    @IBOutlet private(set) weak var inputContainerView: UIView? {
        didSet {
            self.inputContainerView?.layer.borderColor = UIColor.error.cgColor
        }
    }
    @IBOutlet private(set) weak var iconButton: UIButton?
    @IBOutlet private(set) weak var contentView: UIView?
    @IBOutlet private(set) weak var titleLabel: UILabel?
    @IBOutlet private(set) weak var textField: UITextField?

    var state: TextInputViewState = .normal {
        didSet {
            self.updateUI()
        }
    }
    
    weak var delegate: TextInputViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // MARK: - Setup
    
    private func commonInit() {
        self.setupXIB()
        self.textField?.delegate = self
        self.textField?.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    func setupXIB() {
        Bundle.main.loadNibNamed(String(describing: TextInputView.self), owner: self, options: nil)
        
        guard let contentView = contentView else {
            return
        }
        
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - User Actions
    
    @IBAction func onEyeButtonTap(_ sender: Any) {
        // Empty [ML]
    }
    
    // MARK: - UI Updates
    
    private func updateUI() {
        self.updateIcon()
        self.updateContainer()
    }
    
    func updateContainer() {
        switch self.state {
        case .normal:
            self.inputContainerView?.layer.borderWidth = 0
        case .error:
            self.inputContainerView?.layer.borderWidth = 1
        }
    }
    
    func updateIcon() {
        if case .error = self.state {
            self.iconButton?.setImage(kErrorIcon, for: .normal)
            self.iconButton?.isUserInteractionEnabled = false
        } else {
            self.iconButton?.setImage(nil, for: .normal)
            self.iconButton?.isUserInteractionEnabled = true
        }
    }
}

// MARK: - TextFieldDelegate

extension TextInputView: UITextFieldDelegate {
    @objc private func textFieldDidChange() {
        self.delegate?.textInputViewDidChange(self)
    }
}
