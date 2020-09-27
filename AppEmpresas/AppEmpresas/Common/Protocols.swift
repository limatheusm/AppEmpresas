//
//  Protocols.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewProtocol: class {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProtocol: class {

}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProtocol: class {
    
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProtocol: class {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProtocol: class {
    var rootRouter: RootRouterProtocol? { get set }
}
