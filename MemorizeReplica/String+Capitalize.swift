//
//  String+Capitalize.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 08/03/21.
//

import Foundation

extension String {
	
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
