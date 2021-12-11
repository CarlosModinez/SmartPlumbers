//
//  GradientView.swift
//  SmartPlumbers
//
//  Created by ACT on 10/12/21.
//

import Foundation
import UIKit

class GrandientView: UIView {
    private let riskScaleView: UIView = {
        let marginSize: CGFloat = 20
        
        let view = UIView(
            frame: CGRect(x: 0, y: 0,
                width: UIScreen.main.bounds.width - marginSize * 2,
                height: 10
            ))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            FundRisk.getColor(.scale6)().cgColor,
            FundRisk.getColor(.scale4)().cgColor,
            FundRisk.getColor(.scale2)().cgColor,
            FundRisk.getColor(.scale1)().cgColor,
            FundRisk.getColor(.scale3)().cgColor,
            FundRisk.getColor(.scale5)().cgColor,
            FundRisk.getColor(.scale7)().cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 2
        
        view.layer.insertSublayer(gradientLayer, at: 0)

        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(riskScaleView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
