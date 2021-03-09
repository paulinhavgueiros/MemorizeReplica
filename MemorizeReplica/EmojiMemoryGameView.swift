//
//  EmojiMemoryGameView.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 17/02/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
	// MARK: - Instance Properties
	
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
	
	// MARK: - Design Constants
	
	let cornerRadius: CGFloat = 10.0
	let strokeLineWidth: CGFloat = 3.0
	func fontSize(for size: CGSize) -> CGFloat {
		min(size.width, size.height) * 0.75
	}
	let paddingLength: CGFloat = 5.0
	let shortPaddingLength: CGFloat = 2.0
	
	// MARK: - UI Helpers
	
	/* Extra Credit 1 */
	
	var gradientColorArgument: LinearGradient {
		switch viewModel.theme.mainColor {
		case .color(let color):
			return LinearGradient(gradient: Gradient(colors: [color]), startPoint: .topLeading, endPoint: .bottomTrailing)
		case .gradient(let gradientValue):
			return LinearGradient(gradient: gradientValue, startPoint: .topLeading, endPoint: .bottomTrailing)
		}
	}
	
	var mainColor: Color {
		switch viewModel.theme.mainColor {
		case .color(let color):
			return color
		case .gradient(let gradient):
			return gradient.stops.first!.color
		}
	}
	
	// MARK: - UI Build
    
    var body: some View {
		
		VStack {
			Text("Theme: \(viewModel.theme.name)")
				.font(.title3)
				.padding(shortPaddingLength)
			HStack {
				Text("Score: \(viewModel.score)").frame(minWidth: 0, maxWidth: .infinity)
				Button("New Game", action: startNewGame)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: cornerRadius)
							.stroke(lineWidth: strokeLineWidth).fill(gradientColorArgument)
					)
					.frame(minWidth: 0, maxWidth: .infinity)
			}
			Grid(viewModel.cards) { card in
				GeometryReader { geometry in
					ZStack {
						if card.isFaceUp {
							RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
							RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(gradientColorArgument)
							Text(card.content)
						} else if !card.isMatched {
							RoundedRectangle(cornerRadius: cornerRadius).fill(gradientColorArgument)
							RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: strokeLineWidth).fill(Color.white)
						}
					}
					.font(.system(size: fontSize(for: geometry.size)))
				}
				.onTapGesture { viewModel.choose(card: card) }
				.padding(paddingLength)
			}
		}
		.padding()
		.foregroundColor(mainColor)
    }

	// MARK: - Actions
	
	func startNewGame() {
		viewModel.startNewGame()
	}
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
    }
}
