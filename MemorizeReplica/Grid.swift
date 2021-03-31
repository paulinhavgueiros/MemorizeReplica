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
    private var hidden: Bool
	
    init(_ items: [Item], hidden: Bool, viewForItem: @escaping (Item) -> ViewForItem) {
		self.items = items
		self.viewforItem = viewForItem
        self.hidden = hidden
	}
	
    var body: some View {
		GeometryReader { geometry in
			ForEach(items) { item in
                body(for: item, in: GridLayout(itemCount: items.count, nearAspectRatio: 3/4, in: geometry.size), hidden: hidden)
			}
		}
	}

    private func body(for item: Item, in layout: GridLayout, hidden: Bool) -> some View {
		let index = items.firstIndex(matching: item)!
		return viewforItem(item)
            .position(layout.location(ofItemAt: index, hidden: hidden))
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
	}
}
