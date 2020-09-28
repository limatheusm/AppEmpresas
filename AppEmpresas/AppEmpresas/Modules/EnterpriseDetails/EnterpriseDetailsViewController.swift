//
//  EnterpriseDetailsViewController.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 28/09/20.
//

import UIKit

class EnterpriseDetailsViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var headerImageView: UIImageView?
    
    var presenter: EnterpriseDetailsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - User Actions
    
    @IBAction private func onBackButtonTap(_ sender: Any) {
        self.presenter?.onBackButtonTap()
    }
}

extension EnterpriseDetailsViewController: EnterpriseDetailsPresenterToViewProtocol {
    func setupEnterpriseDetails(enterprise: Enterprise) {
        self.titleLabel?.text = enterprise.name
        self.headerImageView?.kf.setImage(with: enterprise.thumbnailURL)
        self.descriptionLabel?.text = enterprise.description
    }
}
