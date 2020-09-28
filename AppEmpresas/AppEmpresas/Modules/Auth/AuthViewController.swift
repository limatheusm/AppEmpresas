//
//  AuthViewController.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import UIKit

class AuthViewController: UIViewController {
    private let kLogoTopConstraintDefaultValue: CGFloat = 70
    
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var headerLabel: UILabel?
    @IBOutlet private weak var logoTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var headerTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var emailTextInputView: EmailTextInputView?{
        didSet {
            self.emailTextInputView?.delegate = self
        }
    }
    @IBOutlet private weak var passwordTextInputView: PasswordTextInputView? {
        didSet {
            self.passwordTextInputView?.delegate = self
        }
    }
    
    private var loadingView = LoadingView()
    private var keyboardStateListener: KeyboardStateListener?
    var presenter: AuthViewToPresenterProtocol?
    
    convenience init(presenter: AuthViewToPresenterProtocol) {
        self.init()
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGestures()
        self.setupKeyboardListener()
    }
    
    // MARK: - Setup
    
    private func setupGestures() {
        self.view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        )
    }
    
    private func setupKeyboardListener() {
        self.keyboardStateListener = KeyboardStateListener(delegate: self)
    }
    
    // MARK: - User Actions
    
    @IBAction private func onSignInButtonTap(_ sender: Any) {
        guard let email = self.emailTextInputView?.textField?.text,
              let password = self.passwordTextInputView?.textField?.text,
              !email.isEmpty(), !password.isEmpty() else {
            return
        }
        
        self.hideKeyboard()
        self.presenter?.signIn(email: email, password: password)
    }
}

// MARK: - AuthPresenterToViewProtocol

extension AuthViewController: AuthPresenterToViewProtocol {
    func onFetchAuthSuccess() {
        self.emailTextInputView?.state = .normal
        self.passwordTextInputView?.state = .normal
        self.errorLabel?.text = ""
    }
    
    func onFetchAuthFailure(errorMessage: String) {
        self.emailTextInputView?.state = .error
        self.passwordTextInputView?.state = .error
        self.errorLabel?.text = errorMessage
    }
    
    func showLoading() {
        self.loadingView.show(in: self.view)
    }
    
    func hideLoading() {
        self.loadingView.dismiss()
    }
}

// MARK: - TextInputViewDelegate

extension AuthViewController: TextInputViewDelegate {
    func textInputViewDidChange(_ textInputView: TextInputView) {
        (textInputView as? EmailTextInputView)?.state = .normal
        (textInputView as? PasswordTextInputView)?.state = .normal
        self.errorLabel?.text = ""
    }
}

// MARK: - KeyboardStateListenerDelegate

extension AuthViewController: KeyboardStateListenerDelegate {
    func keyboardWillShow(_ keyboardStateListener: KeyboardStateListener, keyboardHeight: CGFloat,
                          duration: Double, animationCurve: UIView.AnimationOptions) {
        self.headerTopConstraint?.constant = -(keyboardHeight / 3)
        self.logoTopConstraint?.constant = (self.logoTopConstraint?.constant ?? 0) / 2
        
        UIView.animate(withDuration: duration, delay: .zero, options: animationCurve) {
            self.headerLabel?.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(_ keyboardStateListener: KeyboardStateListener, keyboardHeight: CGFloat,
                          duration: Double, animationCurve: UIView.AnimationOptions) {
        self.headerTopConstraint?.constant = 0
        self.logoTopConstraint?.constant = kLogoTopConstraintDefaultValue
        
        UIView.animate(withDuration: duration, delay: .zero, options: animationCurve) {
            self.headerLabel?.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}
