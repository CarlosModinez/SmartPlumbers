//
//  InvestmentFundsView.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

class AllSensorsView: UIView {
	private let headerInformation = GradientOfRiskView()
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		collection.backgroundColor = .backgroundWhite()
		return collection
	}()
	
	public var collectionViewDelegate: UICollectionViewDelegate? {
		willSet(newValue) {
			collectionView.delegate = newValue
		}
	}
	
	public var collectionViewDataSource: UICollectionViewDataSource? {
		willSet(newValue) {
			collectionView.dataSource = newValue
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		self.backgroundColor = .backgroundGray()

		addSubview(headerInformation)
		addSubview(collectionView)
		collectionView.backgroundColor = .backgroundGray()
		
		
		collectionView.register(
			SingleSensorCollectionViewCell.self,
			forCellWithReuseIdentifier: SingleSensorCollectionViewCell.identifier
		)
		setupConstraints()
	}
	
	private func setupConstraints() {
		headerInformation.anchor(
			top: (safeAreaLayoutGuide.topAnchor, 0),
			right: (rightAnchor, 0),
			left: (leftAnchor, 0),
			height: 100
		)
		
		collectionView.anchor(
			top: (headerInformation.bottomAnchor, 0),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (safeAreaLayoutGuide.bottomAnchor, 0)
		)
	}
	
	public func reloadCollectionData() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.collectionView.reloadData()
		}
	}
}
