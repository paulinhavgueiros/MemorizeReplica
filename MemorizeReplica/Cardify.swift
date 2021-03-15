 //
//  Cardify.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 14/03/21.
//

import SwiftUI

struct Cardify: ViewModifier {
	var isFaceUp: Bool
	var colorGradient: LinearGradient
	var cornerRadius: CGFloat = 10
	var strokeLineWidth: CGFloat = 3

	func body(content: Content) -> some View {
		ZStack {
			if isFaceUp {
				RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(colorGradient)
				content

			} else {
				RoundedRectangle(cornerRadius: cornerRadius).fill(colorGradient)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(Color.white)
			}
		}
	}
}

extension View {
	func cardify(isFaceUp: Bool, colorGradient: LinearGradient, cornerRadius: CGFloat, strokeLineWidth: CGFloat) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp, colorGradient: colorGradient, cornerRadius: cornerRadius, strokeLineWidth: strokeLineWidth))
	}
}
