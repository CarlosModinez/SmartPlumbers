//
//  Temperatures.swift
//  SmartPlumbers
//
//  Created by ACT on 11/12/21.
//

import Foundation

import Foundation

// MARK: - TemperatureElement
struct Temperature: Codable {
    let id, temperature, timestamp: String
}

typealias Temperatures = [Temperature]
