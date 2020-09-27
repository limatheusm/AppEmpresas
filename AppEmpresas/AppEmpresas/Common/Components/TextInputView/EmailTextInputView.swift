//
//  EmailTextInputView.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import UIKit

class EmailTextInputView: TextInputView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel?.text = "Email"
    }
}
