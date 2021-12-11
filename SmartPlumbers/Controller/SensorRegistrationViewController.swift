//
//  SensorRegistrationViewController.swift
//  SmartPlumbers
//
//  Created by ACT on 27/11/21.
//

import UIKit

class SensorRegistrationViewController: SmartSensorDefaultViewController {

    private let viewModel = SensorsViewModel()
    
    private var codeToSensorIdentifier: String? = nil
    private var currentTextField: UITextField?
    private let contentView: UIScrollView = {
        return UIScrollView()
    }()
    private let identifier: UILabel = {
        let label = UILabel()
        label.font = .title2()
        label.textAlignment = .center
        return label
    }()
    
    private let responsibleSectorTextField = DefaultTextField(
        placeholder: "setor responsável", type: .alphabet
    )
    private let maximumTemperatureTextField = DefaultTextField(
        placeholder: "temperatura máxima para alerta", type: .numbersAndPunctuation
    )
    private let minumumTemperatureTextField = DefaultTextField(
        placeholder: "temperatura mínima para alerta", type: .numbersAndPunctuation
    )
    private let idealTemperatureTextField = DefaultTextField(
        placeholder: "temperatura ideal", type: .numbersAndPunctuation
    )
    private let toleranceTextField = DefaultTextField(
        placeholder: "tolerância", type: .numbersAndPunctuation
    )
    private let descriptiontextField = DefaultTextField(
        placeholder: "descrição", type: .alphabet
    )
    private lazy var continueButton: DefaultButton = {
        let button = DefaultButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.setTitle("cadastrar", for: .normal)
        button.action = {
            self.registerSensor()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        responsibleSectorTextField.delegate = self
        maximumTemperatureTextField.delegate = self
        minumumTemperatureTextField.delegate = self
        idealTemperatureTextField.delegate = self
        toleranceTextField.delegate = self
        descriptiontextField.delegate = self
        
        setupUI()
        buildHierarchy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "novo sensor"
    }
        
    init(_ code: String) {
        super.init(nibName: nil, bundle: nil)
        self.codeToSensorIdentifier = code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Criação da view
extension SensorRegistrationViewController {
    private func setupUI() {
        contentView.backgroundColor = .backgroundGray()
        identifier.text = codeToSensorIdentifier
    }
    
    private func buildHierarchy() {
        view.addSubview(contentView)
        contentView.addSubview(identifier)
        contentView.addSubview(responsibleSectorTextField)
        contentView.addSubview(maximumTemperatureTextField)
        contentView.addSubview(minumumTemperatureTextField)
        contentView.addSubview(idealTemperatureTextField)
        contentView.addSubview(toleranceTextField)
        contentView.addSubview(descriptiontextField)
        contentView.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        let topAnchor = view.safeAreaLayoutGuide.topAnchor
        let bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        
        contentView.anchor(
            top: (topAnchor, 0),
            right: (view.rightAnchor, 0),
            left: (view.leftAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
        
        identifier.anchor(
            top: (contentView.topAnchor, 30),
            centerX: (contentView.centerXAnchor, 0)
        )
        
        responsibleSectorTextField.anchor(
            top: (identifier.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        idealTemperatureTextField.anchor(
            top: (responsibleSectorTextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        maximumTemperatureTextField.anchor(
            top: (idealTemperatureTextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        minumumTemperatureTextField.anchor(
            top: (maximumTemperatureTextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        toleranceTextField.anchor(
            top: (minumumTemperatureTextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        descriptiontextField.anchor(
            top: (toleranceTextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20)
        )
        
        continueButton.anchor(
            top: (descriptiontextField.bottomAnchor, 50),
            right: (view.rightAnchor, 20),
            left: (view.leftAnchor, 20),
            bottom: (contentView.bottomAnchor, 30),
            height: 44
        )
    }
}

// MARK: - keyboard controller
extension SensorRegistrationViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let currentHeightPosition = (currentTextField?.frame.origin.y ?? 0.0) + (currentTextField?.frame.height ?? 0)
            let keyboardCovarage = contentView.frame.height - keyboardSize.height - currentHeightPosition
            if keyboardCovarage < 0 {
                self.view.frame.origin.y += keyboardCovarage - 10
            } else {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - TextFieldDelegate
extension SensorRegistrationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextFieldsAccessoryView(textField)
        return true
    }
    
    func setupTextFieldsAccessoryView(_ textField: UITextField) {
        guard textField.inputAccessoryView == nil else {
            print("textfields accessory w view already set up")
            return
        }
        
        let barButton = DefaultButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        barButton.backgroundColor = .green
        barButton.setTitle("continuar", for: .normal)
        barButton.action = { [weak self] in
            self?.view.endEditing(true)
        }
        
        textField.inputAccessoryView = barButton
    }
}

// MARK: - Request
extension SensorRegistrationViewController {
    func registerSensor() {
        let sensor = Sensor(identifier: codeToSensorIdentifier ?? "")
        sensor.description = descriptiontextField.text
        sensor.sector = responsibleSectorTextField.text
        sensor.minimumTemperature = minumumTemperatureTextField.text?.toFloat()
        sensor.maximumTemperature = maximumTemperatureTextField.text?.toFloat()
        sensor.idealTemperature = idealTemperatureTextField.text?.toFloat()
        sensor.toleranceToIdealTemperature = toleranceTextField.text?.toFloat()
        
        viewModel.registerSensor(sensor: sensor) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.viewModel.inputFirstDataSensor(id: sensor.identifier, temperature: sensor.idealTemperature ?? 0) { result in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        if let viewController = self.navigationController?.viewControllers.last(where: { $0 is AllSensorsViewController }) {
                            self.navigationController?.popToViewController(viewController, animated: true)
                        }
                    }
                }
            case .failure(let error):
                self.handlerError(error, onTap: nil)
            }
        }
    }
}
