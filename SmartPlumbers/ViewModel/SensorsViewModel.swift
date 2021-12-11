//
//  InvestmentFundsViewModel.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 13/10/21.
//

import Foundation
import AVFoundation

class SensorsViewModel {
	private let repository = ApiRequest()
    
    func getSensors(completion: @escaping(Result<Sensors?, RequestError>) -> Void) {
        return repository.getAllSensors { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(Sensors.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.responseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func findSensor(id: String, completion: @escaping(Result<Sensor?, RequestError>) -> Void) {
        return repository.findSensor(id: id) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(Sensor.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.responseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func registerSensor(sensor: Sensor, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        return repository.registerSensor(sensor: sensor) { result in
            completion(result)
        }
    }
    
    func inputFirstDataSensor(id: String, temperature: Float, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        let strTemperature = String(temperature)
        repository.postFirstTemperature(id: id, temperature: strTemperature) { result in
            completion(result)
        }
    }
    
    func getTemperaturesById(id: String, date: Date, completion: @escaping(Result<Temperatures?, RequestError>) -> Void) {
        let strDate = date.formatted(date: .numeric, time: .omitted)
        let strParts = strDate.split(separator: "/")
        let strDateFormatted = strParts[2] + "-" + strParts[1] + "-" + strParts[0]
        
        repository.getTemperaturesFromSensor(id: id, date: strDateFormatted) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(Temperatures.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.responseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
