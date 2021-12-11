//
//  DefaultButton.swift
//  SmartPlumbers
//
//  Created by ACT on 10/12/21.
//

import UIKit

class DefaultButton: UIButton {
    var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(doAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doAction() {
        action?()
    }
}
