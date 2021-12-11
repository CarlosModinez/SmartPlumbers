//
//  FundRisk.swift
//  SmartPlumbers
//
//  Created by Carlos Roberto Modinez Junior on 14/10/21.
//

import Foundation
import UIKit

enum FundRisk {
	case scale1
	case scale2
	case scale3
	case scale4
	case scale5
    case scale6
    case scale7
	
	func getColor() -> UIColor {
		switch self {
		case .scale1: return UIColor.green
		case .scale2: return UIColor.cyan
		case .scale3: return UIColor.yellow
		case .scale4: return UIColor.systemBlue
		case .scale5: return UIColor.orange
        case .scale6: return UIColor.blue
        case .scale7: return UIColor.red
		}
	}
	
	static func mapRisk(fundRisk: String) -> FundRisk {
		switch fundRisk {
		case "1", "2": return scale1
        case "3": return scale2
        case "4": return scale3
		case "5", "6": return scale4
		case "7", "8": return scale5
		case "9": return scale7
		case "10": return scale7
		default: return scale5
		}
	}
}
