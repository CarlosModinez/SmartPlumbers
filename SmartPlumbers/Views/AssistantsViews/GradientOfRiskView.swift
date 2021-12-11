//
//  GradientOfRiskView.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

class GradientOfRiskView: UIView {
	private let viewTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.title1()
		label.text = AppStrings.shared.riskScaleTitle
		return label
    }()
    
    private let riskScaleView: GrandientView = {
        return GrandientView()
    }()
    
    private let smallerIndicatorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.title2()
		label.text = AppStrings.shared.riskScaleBigger
		return label
	}()
    
    private let idelIndicatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title2()
        label.text = AppStrings.shared.riskScaleSmaller
        label.textAlignment = .right
        return label
    }()
	
	private let biggerIndicatorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.title2()
		label.text = AppStrings.shared.riskScaleBigger
		label.textAlignment = .right
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		self.backgroundColor = .backgroundGray()
		
		addSubview(viewTitleLabel)
		addSubview(riskScaleView)
        addSubview(idelIndicatorLabel)
		addSubview(smallerIndicatorLabel)
		addSubview(biggerIndicatorLabel)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		viewTitleLabel.anchor(
			top: (topAnchor, 10),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20)
		)
		
		riskScaleView.anchor(
			top: (viewTitleLabel.bottomAnchor, 12),
			right: (viewTitleLabel.rightAnchor, 0),
			left: (viewTitleLabel.leftAnchor, 0),
			height: 10
		)
        
        idelIndicatorLabel.anchor(
            top: (riskScaleView.bottomAnchor, 9),
            centerX: (riskScaleView.centerXAnchor, 0)
        )
        
		smallerIndicatorLabel.anchor(
			top: (riskScaleView.bottomAnchor, 9),
			left: (riskScaleView.leftAnchor, 0)
		)
		
		biggerIndicatorLabel.anchor(
			top: (riskScaleView.bottomAnchor, 9),
			right: (riskScaleView.rightAnchor, 0)
		)
	}
}
