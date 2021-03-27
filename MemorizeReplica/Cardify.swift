 //
//  Cardify.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 14/03/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
	var colorGradient: LinearGradient
	var cornerRadius: CGFloat = 10
	var strokeLineWidth: CGFloat = 3
	
	var angle: Double
	var isFaceUp: Bool {
		angle > 90
	}
	
	var animatableData: Double {
		get { return angle }
		set { angle = newValue }
	}
	
	init(isFaceUp: Bool, colorGradient: LinearGradient, cornerRadius: CGFloat, strokeLineWidth: CGFloat) {
		angle = isFaceUp ? 180 : 0
		self.colorGradient = colorGradient
		self.cornerRadius = cornerRadius
		self.strokeLineWidth = strokeLineWidth
	}

	func body(content: Content) -> some View {
		ZStack {
			Group {
				RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(colorGradient)
				content
			}
			.opacity(isFaceUp ? 1 : 0)
			
			Group {
				RoundedRectangle(cornerRadius: cornerRadius).fill(colorGradient)
				RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(Color.white)
			}
			.opacity(isFaceUp ? 0 : 1)
		}
		.rotation3DEffect(Angle.init(degrees: angle), axis: (0, 1, 0))
	}
}

extension View {
	func cardify(isFaceUp: Bool, colorGradient: LinearGradient, cornerRadius: CGFloat, strokeLineWidth: CGFloat) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp, colorGradient: colorGradient, cornerRadius: cornerRadius, strokeLineWidth: strokeLineWidth))
	}
}
