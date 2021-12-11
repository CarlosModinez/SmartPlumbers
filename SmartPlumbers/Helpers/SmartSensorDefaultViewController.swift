//
//  OramaDefaultViewController.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 13/10/21.
//

import UIKit

class SmartSensorDefaultViewController: UIViewController {
	private let mainView: UIView = {
		let view = UIView(frame: UIScreen.main.bounds)
		view.backgroundColor = .white
		
		return view
	}()
	
	private lazy var loadingView: UIView = {
		let loadIndicator = UIActivityIndicatorView()
		let loadView = UIView()
		
		loadView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		loadView.layer.cornerRadius = 10
		loadView.addSubview(loadIndicator)
		loadIndicator.anchor(
			centerX: (loadView.centerXAnchor, 0),
			centerY: (loadView.centerYAnchor, 0)
		)
		
		loadIndicator.startAnimating()
		
		return loadView
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = view
    }
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		debugPrint("\(String(describing: self))")
	}
}


// MARK: Tratamento de exceções
extension SmartSensorDefaultViewController {
	func handlerError(_ error: RequestError, onTap: (() -> Void)? = nil) {
		let title: String
		let description: String
		
		switch error {
		case .decodingError, .responseError, .invalidUrl:
			title = AppStrings.shared.generalApiErrorTitle
			description = AppStrings.shared.generalApiErrorDescription
		case .noInternetConnection:
			title = AppStrings.shared.internetConnectionFailedTitle
			description = AppStrings.shared.internetConnectionFailedDescription
		}
		
		let alertController = UIAlertController(
			title: NSLocalizedString(title, comment:""),
			message: NSLocalizedString(description, comment:""),
			preferredStyle: .alert)
		
		let defaultAction = UIAlertAction(title: "Ok", style: .default) { dialog in
			onTap?()
		}
		
		alertController.addAction(defaultAction)
		DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
	}
}

extension SmartSensorDefaultViewController {
	public func showLoading() {
		DispatchQueue.main.async {
			self.view.addSubview(self.loadingView)
			self.loadingView.anchor(
				top: (self.view.topAnchor, 0),
				right: (self.view.rightAnchor, 0),
				left: (self.view.leftAnchor, 0),
				bottom: (self.view.bottomAnchor, 0)
			)
		}
	}
	
	public func hideLoading() {
		DispatchQueue.main.async {
			self.loadingView.removeFromSuperview()
		}
	}
}
