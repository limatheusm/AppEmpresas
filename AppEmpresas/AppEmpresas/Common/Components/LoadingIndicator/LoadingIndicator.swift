//
//  LoadingIndicator.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

class LoadingIndicator: UIView {
    private let kRotationAnimationDuration: TimeInterval = 1.5
    
    @IBOutlet private weak var insideImageView: UIImageView?
    @IBOutlet private weak var outsideImageView: UIImageView?
    @IBOutlet private weak var contentView: UIView?
    
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
        self.startAnimation()
    }
    
    func setupXIB() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        
        guard let contentView = contentView else {
            return
        }
        
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func startAnimation() {
        guard let insideLoadingIndicator = self.insideImageView,
              let outsideLoadingIndicator = self.outsideImageView else {
            return
        }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = kRotationAnimationDuration
        rotation.isCumulative = true
        rotation.repeatCount = .infinity
        insideLoadingIndicator.layer.add(rotation, forKey: "rotationAnimation")
        rotation.toValue = CGFloat.pi * -2
        outsideLoadingIndicator.layer.add(rotation, forKey: "rotationAnimation")
    }
}
