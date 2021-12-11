//
//  FundDatailsView.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit
import SwiftChart

class SensorDetailsView: UIView {
	private var sensor: Sensor!
    private var temperatures: [Temperature]?
	private let contentView: UIScrollView = {
		return UIScrollView()
	}()
    private let statusTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.body2()
        title.text = "status do sensor"
        title.textAlignment = .center
        return title
    }()
    private let statusLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont.title1()
		label.textAlignment = .center
		return label
	}()
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.superText()
        label.textAlignment = .center
        return label
    }()
	private let rangeOfTemperatureView: TitleAndValueView = {
		return TitleAndValueView()
	}()
	private let sensorDescriptionView: FundDescriptionWithDecorationView = {
		let view = FundDescriptionWithDecorationView()
		return view
	}()
    private let chartView: Chart = {
        return Chart()
    }()
	
    convenience init(frame: CGRect, sensor: Sensor) {
		self.init(frame: frame)
		self.sensor = sensor
		self.setupUI()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    public func setupChart(temperatures: Temperatures) {
        DispatchQueue.main.async {
            self.temperatures = temperatures
            let series = ChartSeries(temperatures.map { Double($0.temperature) ?? 0 })
            
            self.chartView.add([series])
            self.chartView.xLabels = [0]
            
        
        }
    }
    
    // MARK: - private funcs
	private func setupUI() {
		self.backgroundColor = UIColor.backgroundGray()
        setupDescription()
        setupGradientSensorDetails()
        
        currentTemperatureLabel.text = sensor.getTemperature(edge: .current)
        
		addSubview(contentView)
        contentView.addSubview(statusTitle)
		contentView.addSubview(statusLabel)
        contentView.addSubview(currentTemperatureLabel)
		contentView.addSubview(rangeOfTemperatureView)
		contentView.addSubview(sensorDescriptionView)
        contentView.addSubview(chartView)
		
		setupConstraints()
	}
    
    private func setupGradientSensorDetails() {
        let minumumTemperature = sensor.getTemperature(edge: .minimum)
        let maximumTemperature = sensor.getTemperature(edge: .maximum)
        let idealTemperature = sensor.getTemperature(edge: .ideal)
        rangeOfTemperatureView.title.text = AppStrings.shared.creationDateTitle
        rangeOfTemperatureView.minimumValue.text = minumumTemperature
        rangeOfTemperatureView.maximumValue.text = maximumTemperature
        rangeOfTemperatureView.idealTemperature.text = idealTemperature
    }
    
    private func setupDescription() {
        if let description = sensor.description, let risk = sensor.getRisk() {
            statusLabel.text = risk.getText()
            if risk == .alert || risk == .alertCold { statusLabel.text = risk.getText().uppercased() }
            sensorDescriptionView.setText(description)
            sensorDescriptionView.setColor(risk.getColor())
        }
    }
        
	private func setupConstraints() {
		contentView.anchor(
			top: (safeAreaLayoutGuide.topAnchor, 0),
			right: (self.rightAnchor, 0),
			left: (self.leftAnchor, 0),
			bottom: (safeAreaLayoutGuide.bottomAnchor, 0)
		)
        
        rangeOfTemperatureView.anchor(
            top: (contentView.topAnchor, 25),
            right: (rightAnchor, 20),
            left: (leftAnchor, 20)
        )
		
        statusTitle.anchor(
            top: (rangeOfTemperatureView.bottomAnchor, 40),
            right: (rightAnchor, 40),
            left: (leftAnchor, 40)
        )
        
		statusLabel.anchor(
			top: (statusTitle.bottomAnchor, 4),
			right: (rightAnchor, 40),
			left: (leftAnchor, 40)
		)
        
        currentTemperatureLabel.anchor(
            top: (statusLabel.bottomAnchor, 48),
            centerX: (centerXAnchor, 0)
        )
        
        sensorDescriptionView.anchor(
            top: (currentTemperatureLabel.bottomAnchor, 30),
            right: (rightAnchor, 30),
            left: (leftAnchor, 30)
        )
        
        chartView.anchor(
            top: (sensorDescriptionView.bottomAnchor, 30),
            right: (rightAnchor, 30),
            left: (leftAnchor, 30),
            bottom: (contentView.bottomAnchor, 20),
            height: 200
        )
	}
}
