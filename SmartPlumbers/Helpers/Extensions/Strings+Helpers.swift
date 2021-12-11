//
//  File.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import Foundation

extension String {
	mutating func toCurrency() -> String {
		return "R$ \(self.replacingOccurrences(of: ".", with: ","))"
	}
	
	mutating func toDate() -> String {
		return self.split(separator: "-").reversed().joined(separator: "/")
	}
    
    func toCelsius() -> String {
        let splited = self.split(separator: ".")
        guard splited.last != "0" else { return splited.first!.appending(" ºC") }
        return self.replacingOccurrences(of: ".", with: ",").appending(" ºC")
    }
    
    func toFloat() -> Float {
        let formattedNumber = self.replacingOccurrences(of: ",", with: ".")
        return Float(formattedNumber) ?? 0.0
    }
}
