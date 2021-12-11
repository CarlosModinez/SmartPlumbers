//
//  File.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

class FundDescriptionWithDecorationView: UIView {
	private let decorationView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 5
		view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
		return view
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .left
		label.font = UIFont.body1()
		
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		
		addSubview(decorationView)
		addSubview(descriptionLabel)
		
		decorationView.anchor(
			top: (topAnchor, 0),
			left: (leftAnchor, 0),
			bottom: (bottomAnchor, 0),
			width: 4
		)
		
		descriptionLabel.anchor(
			top: (topAnchor, 0),
			right: (rightAnchor, 0),
			left: (decorationView.leftAnchor, 25),
			bottom: (bottomAnchor, 0)
		)
	}
	
	public func setColor(_ color: UIColor) {
		self.decorationView.backgroundColor = color
	}
	
	public func setText(_ text: String) {
		let attributedString = NSMutableAttributedString(string: text)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 7
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
		
		descriptionLabel.attributedText = attributedString
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
