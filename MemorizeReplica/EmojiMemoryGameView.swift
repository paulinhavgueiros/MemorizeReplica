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
	
	private let cornerRadius: CGFloat = 10
	private let strokeLineWidth: CGFloat = 3
	private func fontSize(for size: CGSize) -> CGFloat {
		min(size.width, size.height) * 0.6
	}
	private let paddingLength: CGFloat = 5
	private let shortPaddingLength: CGFloat = 2
	
	private let startAngle: Double = 0 - 90
	private let endAngle: Double = 110 - 90
	private let opacity: Double = 0.35
	
	// MARK: - UI Helpers
	
	/* Extra Credit 1 */
	
	private var colorGradient: LinearGradient {
		switch viewModel.theme.color {
		case .color(let color):
			return LinearGradient(gradient: Gradient(colors: [color]), startPoint: .topLeading, endPoint: .bottomTrailing)
		case .gradient(let gradientValue):
			return LinearGradient(gradient: gradientValue, startPoint: .topLeading, endPoint: .bottomTrailing)
		}
	}
	
	private var mainColor: Color {
		switch viewModel.theme.color {
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
				Text("Score: \(viewModel.score)")
					.frame(minWidth: 0, maxWidth: .infinity)
				Button("New Game", action: startNewGame)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: cornerRadius)
							.stroke(lineWidth: strokeLineWidth).fill(colorGradient)
					)
					.frame(minWidth: 0, maxWidth: .infinity)
			}
			Grid(viewModel.cards) { card in
				GeometryReader { geometry in
					if card.isFaceUp || !card.isMatched {
						ZStack {
							Pie(startAngle: Angle.degrees(startAngle), endAngle: Angle.degrees(endAngle)).padding(paddingLength).opacity(opacity)
							Text(card.content)
						}
						.cardify(isFaceUp: card.isFaceUp, colorGradient:colorGradient, cornerRadius: cornerRadius, strokeLineWidth: strokeLineWidth)
						.font(.system(size: fontSize(for: geometry.size)))
					}
				}
				.padding(paddingLength)
				.onTapGesture { viewModel.choose(card: card) }
			}
		}
		.padding()
		.foregroundColor(mainColor)
    }

	// MARK: - Actions
	
	private func startNewGame() {
		viewModel.startNewGame()
	}
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let gameViewModel = EmojiMemoryGameViewModel()
		gameViewModel.choose(card: gameViewModel.cards[0])
        return EmojiMemoryGameView(viewModel: gameViewModel)
    }
}
