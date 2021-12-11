//
//  Sensors.swift
//  SmartPlumbers
//
//  Created by ACT on 27/11/21.
//

import UIKit

enum SensorStatus: Int {
    case alert = 0
    case alertCold
    case attention
    case attentionCold
    case overheated
    case underTemperature
    case normal
    
    func getColor() -> UIColor {
        switch self {
        case .alertCold: return UIColor.systemBlue
        case .attentionCold: return UIColor.blue
        case .underTemperature: return UIColor.cyan
        case .normal: return UIColor.green
        case .overheated: return UIColor.yellow
        case .attention: return UIColor.orange
        case .alert: return UIColor.red
        }
    }
    
    func getText() -> String {
        switch self {
        case .alertCold: return "Alerta"
        case .attentionCold: return "Atenção"
        case .underTemperature: return "Abaixo da temperatura ideal"
        case .normal: return "Normal"
        case .overheated: return "Sobreaquecido"
        case .attention: return "Atenção"
        case .alert: return "Alerta"
        }
    }
}

enum EdgeTemperature {
    case minimum
    case maximum
    case ideal
    case current
}

typealias Sensors = [Sensor]

class Sensor: Codable {
    let identifier: String
    var description: String?
    var sector: String?
    var minimumTemperature: Float?
    var maximumTemperature: Float?
    var idealTemperature: Float?
    var toleranceToIdealTemperature: Float?
    var currentTemperature: Float?
    
    var pressure: Float?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case description, sector, minimumTemperature, maximumTemperature, idealTemperature, currentTemperature, toleranceToIdealTemperature
    }
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    func getDictSensor() -> [String: Any?] {
        return [
            "identifier": identifier,
            "description": description,
            "sector": sector,
            "minimumTemperature": minimumTemperature,
            "maximumTemperature": maximumTemperature,
            "idealTemperature": idealTemperature,
            "toleranceToIdealTemperature": toleranceToIdealTemperature,
        ]
    }
    
    func getTemperature(edge: EdgeTemperature) -> String {
        guard let currentTemperature = currentTemperature,
              let minimumTemperature = minimumTemperature,
              let maximumTemperature = maximumTemperature,
              let idealTemperature = idealTemperature
        else { return "" }
        
        switch edge {
            
            
        case .minimum: return String(round(100 * minimumTemperature) / 100).toCelsius()
        case .maximum: return String(round(100 * maximumTemperature) / 100).toCelsius()
        case .ideal: return String(round(100 * idealTemperature) / 100).toCelsius()
        case .current: return String(round(100 * currentTemperature) / 100).toCelsius()
        }
    }
                                     
    func getRisk() -> SensorStatus? {
        guard var minimumTemperature = minimumTemperature,
              var currentTemperature = currentTemperature,
              var maximumTemperature = maximumTemperature,
              var idealTemperature = idealTemperature,
              let toleranceToIdealTemperature = toleranceToIdealTemperature
        else { return nil }
        var status: SensorStatus = .normal
        
        if minimumTemperature < 0 {
            currentTemperature = currentTemperature - minimumTemperature
            maximumTemperature = maximumTemperature - minimumTemperature
            idealTemperature = idealTemperature - maximumTemperature
            minimumTemperature = 0
        }
        
        //MARK: - Abaico da temperatura de tolerância
        if currentTemperature < idealTemperature - toleranceToIdealTemperature {
            let step = (idealTemperature - minimumTemperature) / 3
            if currentTemperature < idealTemperature - 2 * step {
                status = .alertCold
            } else if currentTemperature < idealTemperature - step {
                status = .attentionCold
            } else {
                status = .underTemperature
            }
        }
        
        //MARK: - Acima da temperatura com tolerância
        if currentTemperature > idealTemperature + toleranceToIdealTemperature {
            let step = (maximumTemperature - idealTemperature) / 3
            if currentTemperature > 2 * step + idealTemperature {
                status = .alert
            } else if currentTemperature > step + idealTemperature {
                status = .attention
            } else {
                status = .overheated
            }
        }
        
        return status
    }
}
