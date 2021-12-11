//
//  Strings.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import Foundation

class AppStrings {
	static let shared = AppStrings()
	
	var fundsPageTitle: String { return getString("fundsPageTitle") }
	var riskScaleTitle: String { return getString("riskScaleTitle") }
	var riskScaleSmaller: String { return getString("riskScaleSmaller") }
	var riskScaleBigger: String { return getString("riskScaleBigger") }
	func minimumApplicationValueText(value: String) -> String { return getString("minimumApplicationValueText", args: value)}
	
	var detailsPageTitle: String { return getString("detailsPageTitle") }
	var creationDateTitle: String { return getString("creationDateTitle") }
	var minimumValueTitle: String { return getString("minimumValueTitle") }
	
	var internetConnectionFailedTitle: String { return getString("internetConnectionFailedTitle") }
	var internetConnectionFailedDescription: String { return getString("internetConnectionFailedDescription") }
	var generalApiErrorTitle: String { return getString("generalApiErrorTitle") }
	var generalApiErrorDescription: String { return getString("generalApiErrorDescription") }
	
	private func getString(_ key: String, args: String...) -> String {
		return String(format: Bundle.main.localizedString(forKey: key, value: nil, table: "AppStrings"), arguments: args)
	}
}

