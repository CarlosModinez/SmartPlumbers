//
//  Requests.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 13/10/21.
//

import Foundation
import SwiftyJSON

fileprivate enum HttpRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

fileprivate struct SmartPlumberRequests {
    private static let hostUrl = "http://192.168.15.62:3000"
    
    private struct crudSensor {
        static let getAllSensorsEndpoints = "/api/sensor/list"
        static let registerSensorEndpoint = "/api/sensor/register"
        static let findSensorEndpoint = "/api/sensor/find"
        static let updateSensorEndpoint = "/api/sensor/update"
        static let removeSensorEndpoint = "/api/sensor/remove"
    }
    
    private struct crudTemperatures {
        static let receiveDataEndpoint = "/api/smartPlumber/sendData/sensor"
        static let firstTemperatureEndpoint = "/api/smartPlumber/receiveData/sensor"
    }
}

extension SmartPlumberRequests {
    
    // MARK - CRUD SENSOR
    static func getAllSensorsEndpoints() -> URL? { return URL(string: hostUrl + crudSensor.getAllSensorsEndpoints)}
    static func registerSensorEndpoint() -> URL? { return URL(string: hostUrl + crudSensor.registerSensorEndpoint) }
    static func findSensorEndpoint(id: String) -> URL? { return URL(string: hostUrl + crudSensor.findSensorEndpoint + "/" + id) }
    static func updateSensorEndpoint() -> URL? { return URL(string: hostUrl + crudSensor.updateSensorEndpoint) }
    static func removeSensorEndpoint() -> URL? { return URL(string: hostUrl + crudSensor.removeSensorEndpoint) }
    
    // MARK - CRUD TEMPERATURE
    static func getTemperatureByIdEndpoint(id: String, date: String) -> URL? {
        return URL(string: hostUrl + crudTemperatures.receiveDataEndpoint + "/" + id + "/" + "date" + "/" + date)
    }
    static func postFirstTemperatureEndpoint(id: String, temperature: String) -> URL? {
        return URL(string: hostUrl + crudTemperatures.firstTemperatureEndpoint + "/" + id + "/" + "temperature" + "/" + temperature)
    }
}

class ApiRequest: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    func getAllSensors(completion: @escaping(Result<Data?, RequestError>) -> Void) {
        self.mekeRequest(method: .get, url: SmartPlumberRequests.getAllSensorsEndpoints()) { result in
            completion(result)
        }
    }
    
    func findSensor(id: String, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        self.mekeRequest(method: .get, url: SmartPlumberRequests.findSensorEndpoint(id: id)) { result in
            completion(result)
        }
    }
    
    func registerSensor(sensor: Sensor, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        self.mekeRequest(method: .post, url: SmartPlumberRequests.registerSensorEndpoint(), body: sensor.getDictSensor()) { result in
            completion(result)
        }
    }
    
    func postFirstTemperature(id: String, temperature: String, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        self.mekeRequest(method: .post, url: SmartPlumberRequests.postFirstTemperatureEndpoint(id: id, temperature: temperature)) { result in
            completion(result)
        }
    }
    
    func getTemperaturesFromSensor(id: String, date: String, completion: @escaping(Result<Data?, RequestError>) -> Void) {
        self.mekeRequest(method: .get, url: SmartPlumberRequests.getTemperatureByIdEndpoint(id: id, date: date)) { result in
            completion(result)
        }
    }
    
    private func mekeRequest(method: HttpRequestMethod, url: URL?, body: [String: Any?]? = nil, completion: @escaping (Result<Data?, RequestError>) -> Void) {
        guard let url = url else { return }
        debugPrint("... calling \(url)")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 300
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch {
                completion(.failure(.decodingError))
                debugPrint("❌ decoding error")
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                debugPrint("")
                completion(.failure(.responseError))
                return
            }

            guard (200 ... 299) ~= response.statusCode else {
                debugPrint("❌ statusCode should be 2xx, but is \(response.statusCode)")
                debugPrint("response = \(response)")
                completion(.failure(.responseError))
                return
            }
            
            debugPrint("✅ Response got successfully")
            completion(.success(data))
            return
        }.resume()
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        task.cancel()
    }

}


extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
