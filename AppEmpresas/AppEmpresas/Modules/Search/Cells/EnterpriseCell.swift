//
//  EnterpriseCell.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import UIKit
import Kingfisher

class EnterpriseCell: UITableViewCell {
    static let kIdentifier = String(describing: EnterpriseCell.self)
    static let kHeight: CGFloat = 120
    
    @IBOutlet private weak var backgroundImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundImageView?.image = nil
        self.titleLabel?.text = ""
    }
    
    // MARK: - Setup
    
    func setup(with enterprise: Enterprise) {
        self.titleLabel?.text = enterprise.name
        self.backgroundImageView?.kf.setImage(with: enterprise.thumbnailURL)
    }
    
}
