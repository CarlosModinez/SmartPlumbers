//
//  RequestError.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 13/10/21.
//

import Foundation

enum RequestError: Error {
	case invalidUrl
	case noInternetConnection
	case decodingError
	case responseError
}
