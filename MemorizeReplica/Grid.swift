//
//  Grid.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 07/03/21.
//

import SwiftUI

struct Grid<Item, ViewForItem>: View where Item: Identifiable, ViewForItem: View {
	private var items: [Item]
	private var viewforItem: (Item) -> ViewForItem
	
	init(_ items: [Item], viewForItem: @escaping (Item) -> ViewForItem) {
		self.items = items
		self.viewforItem = viewForItem
	}
	
    var body: some View {
		GeometryReader { geometry in
			ForEach(items) { item in
				body(for: item, in: GridLayout(itemCount: items.count, nearAspectRatio: 2/3, in: geometry.size))
			}
		}
	}

	private func body(for item: Item, in layout: GridLayout) -> some View {
		let index = items.firstIndex(matching: item)!
		return viewforItem(item).position(layout.location(ofItemAt: index)).frame(width: layout.itemSize.width, height: layout.itemSize.height)
	}
}
