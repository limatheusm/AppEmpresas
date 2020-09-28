//
//  SearchContract.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol SearchPresenterToViewProtocol: PresenterToViewProtocol {
    var presenter: SearchViewToPresenterProtocol? { get set }
    
    func onUserSessionExpired()
    func onSearchSuccess(resultsText: String)
    func onSearchFailure(errorMessage: String)
    func showLoading()
    func hideLoading()
    func updateHeader(isClosed: Bool)
    func closeKeyboard()
    func setEmptyResultsLabelVisibility(isHidden: Bool)
}

// MARK: View Input (View -> Presenter)
protocol SearchViewToPresenterProtocol: ViewToPresenterProtocol {
    var enterprises: [Enterprise] { get set }
    var view: SearchPresenterToViewProtocol? { get set }
    var interactor: SearchPresenterToInteractorProtocol? { get set }
    var router: SearchPresenterToRouterProtocol? { get set }
    
    func search(text: String)
    func numberOfRowsInSection() -> Int
    func didSelectRow(at index: Int)
    func scrollViewDidScroll()
    func enterpriseForRow(at index: Int) -> Enterprise
    func backgroundViewDidTap()
    func textFieldDidBeginEditing()
    func didTapUserSessionExpiredAlertButton()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol SearchPresenterToInteractorProtocol: PresenterToInteractorProtocol {
    var presenter: SearchInteractorToPresenterProtocol? { get set }
    var repository: EnterpriseRepository? { get set }
    
    func search(name: String)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol SearchInteractorToPresenterProtocol: InteractorToPresenterProtocol {
    func fetchSearchSuccess(enterprises: [Enterprise])
    func fetchSearchFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol SearchPresenterToRouterProtocol: PresenterToRouterProtocol {
    static func createModule(rootRouter: RootRouterProtocol) -> UINavigationController
    var context: UINavigationController { get set }
    
    func switchToSignOut()
    func push(destination: SearchDestination)
}
