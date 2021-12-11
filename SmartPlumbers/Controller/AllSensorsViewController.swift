//
//  InvestmentFundsViewController.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 24/11/21.
//

import UIKit
import AVFoundation

class AllSensorsViewController: SmartSensorDefaultViewController {
	private let viewModel = SensorsViewModel()
	private lazy var fundsView: AllSensorsView = {
		return self.view as! AllSensorsView
	}()
	
    private var sensors: Sensors?
    private var gettingSensors = false
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
        self.getSensors()
        self.navigationItem.title = AppStrings.shared.fundsPageTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewSensor(sender:))
        )
	}
	
	override func loadView() {
		self.view = AllSensorsView(frame: UIScreen.main.bounds)
		fundsView.collectionViewDataSource = self
		fundsView.collectionViewDelegate = self
	}
	
	private func goToSensorDetailed(_ sensor: Sensor) {
		self.navigationController?.pushViewController(SensorDetailsViewController(sensorToShow: sensor), animated: true)
	}
    
    @objc private func addNewSensor(sender: UIBarButtonItem) {
        requestPermission()
    }
    
    private func requestPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: navigationController?.pushViewController(QrCodeReadingViewController(), animated: true)
        case .denied: return
        case .restricted: return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] _ in
                self?.requestPermission()
            }
        @unknown default: return
        }
    }
}

extension AllSensorsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.sensors?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleSensorCollectionViewCell.identifier, for: indexPath) as? SingleSensorCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		if let sensor = sensors?[indexPath.row] { cell.config(sensor: sensor) }
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let sensor = sensors?[indexPath.row] {
			goToSensorDetailed(sensor)
		}
	}
}

extension AllSensorsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
		let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let size = Double(collectionView.bounds.width - totalSpace) / 2.1
		
        return CGSize(width: size, height: size * 1.5)
	}
}

// MARK: Extensão para recarregar os dados quando houver um scroll up
extension AllSensorsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let verticalContenteOffset = scrollView.contentOffset.y
		let minScrollPositionToReload: CGFloat = -100.0
		if verticalContenteOffset < minScrollPositionToReload { getSensors() }
	}
}

// MARK: Requisição dos fundos
extension AllSensorsViewController {
	private func getSensors() {
        guard !gettingSensors else { return }
        gettingSensors = true
        self.showLoading()
        viewModel.getSensors { [weak self] result in
			guard let self = self else { return }
            self.gettingSensors = false
            self.hideLoading()
            switch result {
			case .success(let value):
                self.sensors = value?.sorted(by: { $0.getRisk()?.rawValue ?? 0 < $1.getRisk()?.rawValue ?? 0})
                
			case .failure(let error):
				self.handlerError(error) {
                    
				}
			}

			self.fundsView.reloadCollectionData()
		}
	}
}
