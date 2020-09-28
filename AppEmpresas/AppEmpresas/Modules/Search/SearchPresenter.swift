//
//  SearchPresenter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

class SearchPresenter: SearchViewToPresenterProtocol {
    var enterprises: [Enterprise] = []
    var interactor: SearchPresenterToInteractorProtocol?
    var router: SearchPresenterToRouterProtocol?
    
    weak var view: SearchPresenterToViewProtocol?
    
    init(view: SearchPresenterToViewProtocol,
         interactor: SearchPresenterToInteractorProtocol,
         router: SearchPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func numberOfRowsInSection() -> Int {
        return self.enterprises.count
    }
    
    func didSelectRow(at index: Int) {
        // TODO: Route with index [ML]
    }
    
    func enterpriseForRow(at index: Int) -> Enterprise {
        self.enterprises[index]
    }
    
    func search(text: String) {
        self.view?.showLoading()
        self.interactor?.search(name: text)
    }
    
    func scrollViewDidScroll() {
        self.hideKeyboardAndOpenUpdateHeaderIfNeeded()
    }
    
    func backgroundViewDidTap() {
        self.hideKeyboardAndOpenUpdateHeaderIfNeeded()
    }
    
    func textFieldDidBeginEditing() {
        self.view?.updateHeader(isClosed: true)
    }
    
    func didTapUserSessionExpiredAlertButton() {
        self.router?.switchToSignOut()
    }
    
    // MARK: - Helpers
    
    private func hideKeyboardAndOpenUpdateHeaderIfNeeded() {
        self.view?.closeKeyboard()
        if self.enterprises.isEmpty {
            self.view?.updateHeader(isClosed: false)
        }
    }
}

extension SearchPresenter: SearchInteractorToPresenterProtocol {
    func fetchSearchSuccess(enterprises: [Enterprise]) {
        self.enterprises = enterprises
        self.view?.hideLoading()
        self.view?.onSearchSuccess()
    }
    
    func fetchSearchFailure(error: Error) {
        self.view?.hideLoading()
        
        guard (error as NSError).code != 401 else {
            self.view?.onUserSessionExpired()
            return
        }
        
        self.view?.onSearchFailure(errorMessage: error.localizedDescription)
    }
}
