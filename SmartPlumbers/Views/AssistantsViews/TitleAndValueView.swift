//
//  TitleAndValueView.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

class TitleAndValueView: UIView {
	public let title: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.body2()
		return label
	}()
	
	public let minimumValue: UILabel = {
		let label = UILabel()
		label.font = UIFont.title2()
		label.textAlignment = .center
		return label
	}()
    
    public let maximumValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.title2()
        label.textAlignment = .center
        return label
    }()
    
    public let idealTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.title2()
        label.textAlignment = .center
        return label
    }()
        
    private let gradientView: GrandientView = {
        return GrandientView()
    }()

	
	init() {
		super.init(frame: .zero)
		
		addSubview(title)
		addSubview(minimumValue)
        addSubview(idealTemperature)
        addSubview(maximumValue)
        addSubview(gradientView)
		
		title.anchor(
			top: (topAnchor, 0),
			right: (rightAnchor, 0),
			left: (leftAnchor, 0)
		)
		
		minimumValue.anchor(
			top: (title.bottomAnchor, 4),
			left: (leftAnchor, 0),
			bottom: (bottomAnchor, 0)
		)
        
        idealTemperature.anchor(
            top: (minimumValue.topAnchor, 0),
            bottom: (bottomAnchor, 0),
            centerX: (centerXAnchor, 0)
        )
        
        maximumValue.anchor(
            top: (minimumValue.topAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
        
        gradientView.anchor(
            top: (maximumValue.bottomAnchor, 10),
            right: (rightAnchor, 0),
            left: (leftAnchor, 0),
            bottom: (bottomAnchor, 0),
            height: 10
        )
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
