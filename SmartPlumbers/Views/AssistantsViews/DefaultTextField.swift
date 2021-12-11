//
//  DefaultTextField.swift
//  SmartPlumbers
//
//  Created by ACT on 10/12/21.
//

import UIKit

class DefaultTextField: UITextField {
    
    init(placeholder: String? = "", type: UIKeyboardType? = .alphabet) {
        super.init(frame: .zero)
        if let placeholder = placeholder { self.placeholder = placeholder }
        if let type = type { self.keyboardType = type }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
