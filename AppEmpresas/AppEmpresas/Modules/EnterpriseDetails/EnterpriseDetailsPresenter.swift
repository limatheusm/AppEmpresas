//
//  EnterpriseDetailsPresenter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 28/09/20.
//

import Foundation

class EnterpriseDetailsPresenter: EnterpriseDetailsViewToPresenterProtocol {
    var view: EnterpriseDetailsPresenterToViewProtocol?
    var router: EnterpriseDetailsPresenterToRouterProtocol?
    var enterprise: Enterprise
    
    init(view: EnterpriseDetailsPresenterToViewProtocol?,
         router: EnterpriseDetailsPresenterToRouterProtocol?,
         enterprise: Enterprise) {
        self.view = view
        self.router = router
        self.enterprise = enterprise
    }
    
    func viewDidLoad() {
        self.view?.setupEnterpriseDetails(enterprise: self.enterprise)
    }
    
    func onBackButtonTap() {
        self.router?.pop()
    }
}
