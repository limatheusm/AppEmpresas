//
//  SearchViewController.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import UIKit

class SearchViewController: UIViewController {
    private let kHeaderTopConstraintValueWhenClosed: CGFloat = -100
    private let kAnimationDuration: TimeInterval = 0.3
    
    @IBOutlet private weak var searchTextField: UITextField?
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var resultsCountLabel: UILabel?
    @IBOutlet private weak var searchContainerView: UIView?
    @IBOutlet private weak var headerTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var loadingIndicator: LoadingIndicator?
    
    var presenter: SearchViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerTableViewCell()
        self.setupGestures()
        self.setupSearchTextField()
    }
    
    // MARK: - Setup
    
    private func registerTableViewCell() {
        self.tableView?.register(UINib(nibName: EnterpriseCell.kIdentifier, bundle: nil),
                                 forCellReuseIdentifier: EnterpriseCell.kIdentifier)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backgroundViewDidTap))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupSearchTextField() {
        self.searchTextField?.delegate = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Gestures
    
    @objc private func backgroundViewDidTap() {
        self.presenter?.backgroundViewDidTap()
    }
    
    // MARK: - Search
    
    private func search() {
        guard let text = self.searchTextField?.text, !text.isEmpty() else {
            return
        }
        
        self.presenter?.search(text: text)
    }
}

// MARK: - Tableview

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnterpriseCell.kIdentifier)
                as? EnterpriseCell else {
            return EnterpriseCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let enterpriseCell = cell as? EnterpriseCell,
              let enterprise = self.presenter?.enterpriseForRow(at: indexPath.row) else {
            return
        }
        
        enterpriseCell.setup(with: enterprise)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EnterpriseCell.kHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.presenter?.scrollViewDidScroll()
    }
}

// MARK: - SearchPresenterToViewProtocol

extension SearchViewController: SearchPresenterToViewProtocol {
    func onSearchSuccess(resultsText: String) {
        let range = NSMakeRange(0, self.tableView?.numberOfSections ?? 0)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView?.reloadSections(sections as IndexSet, with: .automatic)
        self.resultsCountLabel?.text = resultsText
    }
    
    func onSearchFailure(errorMessage: String) {
        // TODO: Implement Error view [ML]
        self.resultsCountLabel?.text = ""
    }
    
    func showLoading() {
        self.loadingIndicator?.showAnimated()
    }
    
    func hideLoading() {
        self.loadingIndicator?.hideAnimated()
    }
    
    func updateHeader(isClosed: Bool) {
        let newValue = isClosed ? kHeaderTopConstraintValueWhenClosed : 0
        
        guard self.headerTopConstraint?.constant != newValue else {
            return
        }
        
        self.headerTopConstraint?.constant = newValue
        
        UIView.animate(withDuration: kAnimationDuration, delay: .zero, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func closeKeyboard() {
        self.hideKeyboard()
    }
    
    func onUserSessionExpired() {
        self.alert(message: "Your session expired, please sign in again.", title: "Ops!") {
            self.presenter?.didTapUserSessionExpiredAlertButton()
        }
    }
}

// MARK: - TextField

extension SearchViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange() {
        self.search()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.search()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.presenter?.textFieldDidBeginEditing()
    }
}
