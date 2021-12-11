//
//  FundDatailsViewController.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 13/10/21.
//

import UIKit
import Charts

class SensorDetailsViewController: SmartSensorDefaultViewController {
	private let viewModel = SensorsViewModel()
    private var temperatures: Temperatures?
    
	private var sensor: Sensor!
	private lazy var detailView: SensorDetailsView = {
		return self.view as! SensorDetailsView
	}()
	
	init(sensorToShow sensor: Sensor) {
		super.init(nibName: nil, bundle: nil)
		self.sensor = sensor
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigationBar()
        getTemperatures()
	}
	
	override func loadView() {
		self.view = SensorDetailsView(frame: UIScreen.main.bounds, sensor: sensor)
	}
	
	private func setupNavigationBar() {
		self.navigationItem.title = AppStrings.shared.detailsPageTitle  
	}
}

// MARK: - Request
extension SensorDetailsViewController {
    func getTemperatures() {
        viewModel.getTemperaturesById(id: sensor.identifier, date: Date()) { result in
            switch result {
            case .success(let temperatures):
                guard let temperatures = temperatures else { return }
                self.detailView.setupChart(temperatures: temperatures)
            case .failure(let error):
                self.handlerError(error, onTap: nil)
            }
        }
    }
}
