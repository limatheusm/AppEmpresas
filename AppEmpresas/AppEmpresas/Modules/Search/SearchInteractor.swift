//
//  SearchInteractor.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

class SearchInteractor: SearchPresenterToInteractorProtocol {
    var repository: EnterpriseRepository?
    
    weak var presenter: SearchInteractorToPresenterProtocol?
    
    init(repository: EnterpriseRepository = EnterpriseDataManager()) {
        self.repository = repository
    }
    
    func search(name: String) {
        self.repository?.getEnterprises(name: name, type: nil, completion: { result in
            switch result {
            case .failure(let error):
                self.presenter?.fetchSearchFailure(error: error)
            case .success(let enterprises):
                self.presenter?.fetchSearchSuccess(enterprises: enterprises)
            }
        })
    }
}
