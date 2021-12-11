//
//  UIFont+Helpers.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import UIKit

extension UIFont {
    static func superText() -> UIFont {
        return UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
	static func title1() -> UIFont {
		return UIFont.systemFont(ofSize: 16, weight: .bold)
	}
	
	static func title2() -> UIFont {
		return UIFont.systemFont(ofSize: 14, weight: .bold)
	}
	
	static func body1() -> UIFont {
		return UIFont.systemFont(ofSize: 14, weight: .regular)
	}
	
	static func body2() -> UIFont {
		return UIFont.systemFont(ofSize: 12, weight: .thin)
	}
}
