//
//  Array+Only.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 07/03/21.
//

import Foundation

extension Array {
	
	func only() -> Element? {
		return (count == 1) ? first : nil
	}
}
