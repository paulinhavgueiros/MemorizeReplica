//
//  Array+Identifiable.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 07/03/21.
//

import Foundation

extension Array where Element: Identifiable {
	
	func firstIndex(matching element: Element) -> Int? {
		for index in 0..<self.count {
			if self[index].id == element.id {
				return index
			}
		}
		return nil
	}
}
