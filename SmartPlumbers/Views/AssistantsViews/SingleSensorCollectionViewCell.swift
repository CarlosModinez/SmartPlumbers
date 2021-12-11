//
//  SingleFundCell.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

class SingleSensorCollectionViewCell: UICollectionViewCell {
	static var identifier = "SingleFundCollectionViewCell"
	
	private let backView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.layer.borderWidth = 0.5
		view.layer.borderColor = UIColor.lightGray.cgColor
		view.backgroundColor = .white
		
		return view
	}()
	
	private let sensorStatus: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.body1()
		return label
	}()
    
    private let currentTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.superText()
        return label
    }()
	
    private let responsibleSectortitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.body2()
        label.text = "setor responsável"
        return label
    }()
    
	private let responsibleSector: UILabel = {
		let label = UILabel()
		label.font = UIFont.title2()
		return label
	}()
	
	private let sensorRisk: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 5
		view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
		
		return view
	}()
	
	func config(sensor: Sensor) {
        guard let risk = sensor.getRisk() else { return }
        sensorRisk.backgroundColor = risk.getColor()
        responsibleSector.text = sensor.sector ?? ""
        currentTemperature.text = sensor.getTemperature(edge: .current)
        self.sensorStatus.text = risk.getText()
        
        if risk == .alert || risk == .alertCold {
            sensorStatus.text = sensorStatus.text?.uppercased()
            sensorStatus.textColor = .red
            sensorStatus.font = .title1()
        } else {
            sensorStatus.text = sensorStatus.text?.lowercased()
            sensorStatus.textColor = .black
        }
		
		self.contentView.addSubview(backView)
		backView.addSubview(sensorRisk)
        backView.addSubview(currentTemperature)
		backView.addSubview(sensorStatus)
        backView.addSubview(responsibleSectortitle)
		backView.addSubview(responsibleSector)

		backView.anchor(
			top: (contentView.topAnchor, 0),
			right: (contentView.rightAnchor, 0),
			left: (contentView.leftAnchor, 0),
			bottom: (contentView.bottomAnchor, 0)
		)
		
		sensorRisk.anchor(
			top: (backView.topAnchor, 10),
			left: (backView.leftAnchor, 0),
			bottom: (backView.bottomAnchor, 10),
			width: 4
		)
		
		sensorStatus.anchor(
            top: (backView.topAnchor, 25),
            right: (backView.rightAnchor, 15),
            left: (backView.leftAnchor, 15)
		)
        
        currentTemperature.anchor(
            centerX: (backView.centerXAnchor, 0),
            centerY: (backView.centerYAnchor, 0)
        )
        
        responsibleSectortitle.anchor(
            bottom: (responsibleSector.topAnchor, 2),
            centerX: (backView.centerXAnchor, 0)
        )
        
		responsibleSector.anchor(
            bottom: (backView.bottomAnchor, 25),
            centerX: (backView.centerXAnchor, 0)
		)
	}
}
