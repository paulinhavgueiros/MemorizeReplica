//
//  EmojiMemoryGameView.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 17/02/21.
//

import SwiftUI

struct EmojiMemoryGameDesignConstants {
	static let cornerRadius: CGFloat = 10
	static let strokeLineWidth: CGFloat = 3
	static let paddingLength: CGFloat = 5
	static let shortPaddingLength: CGFloat = 2

	static let offsetAngle: Double = -90
	static let startAngle: Double = 0
	static let opacity: Double = 0.3
}

typealias Constant = EmojiMemoryGameDesignConstants

struct EmojiMemoryGameView: View {
	// MARK: - Instance Properties
	
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    @State var cardsAreHidden = true
    
    // MARK: - Animation
    
    private func showCards() {
        withAnimation(.easeInOut) {
            cardsAreHidden = false
        }
    }
    
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
				.padding(Constant.shortPaddingLength)
			HStack {
				Text("Score: \(viewModel.score)")
					.frame(minWidth: 0, maxWidth: .infinity)
				Button("New Game", action: {
					withAnimation(.easeInOut) {
                        viewModel.startNewGame()
					}
				})
				.padding()
				.overlay(
					RoundedRectangle(cornerRadius: Constant.cornerRadius)
						.stroke(lineWidth: Constant.strokeLineWidth).fill(colorGradient)
				)
				.frame(minWidth: 0, maxWidth: .infinity)
			}
            Grid(viewModel.cards, hidden: cardsAreHidden) { card in
				CardView(card: card, colorGradient: colorGradient)
					.padding(Constant.paddingLength)
					.onTapGesture {
						 withAnimation(.linear) {
							 viewModel.choose(card: card)
						 }
					 }
			}
            .onAppear {
                showCards()
            }
		}
		.padding()
		.foregroundColor(mainColor)
	}
}

struct CardView: View {
	// MARK: - Instance Properties
	
	var card: MemoryGame<String>.Card
	let colorGradient: LinearGradient
    let rotationAnimationDuration = 0.8
    let fontToViewProportion: CGFloat = 0.6
	@State private var animatedBonusRemaining: Double = 0
	
	// MARK: - Design Constants

	private func fontSize(for size: CGSize) -> CGFloat {
		min(size.width, size.height) * fontToViewProportion
	}
	
	// MARK: - Animation
	
	private func animateBonus() {
		animatedBonusRemaining = card.bonusRemaining
		withAnimation(.linear(duration: card.bonusTimeRemaining)) {
			animatedBonusRemaining = 0
		}
	}
	
	// MARK: - UI Build
	
	var body: some View {
		GeometryReader { geometry in
			body(for: geometry.size)
		}
	}
	
	@ViewBuilder
	private func body(for size: CGSize) -> some View {
		if card.isFaceUp || !card.isMatched {
			ZStack {
				Group {
					if card.isConsumingBonusTime {
						Pie(
							startAngle: Angle.degrees(Constant.offsetAngle + Constant.startAngle),
							endAngle: Angle.degrees(Constant.offsetAngle + animatedBonusRemaining*360),
							clockwise: false
						).onAppear {
							animateBonus()
						}
					} else {
						Pie(
							startAngle: Angle.degrees(Constant.offsetAngle + Constant.startAngle),
							endAngle: Angle.degrees(Constant.offsetAngle + card.bonusRemaining*360),
							clockwise: false)
					}
				}
				.padding(Constant.paddingLength)
				.opacity(Constant.opacity)

				Text(card.content)
					.rotationEffect(Angle.degrees(card.isMatched ? -360 : 0))
					.animation(card.isMatched ? Animation.linear(duration: rotationAnimationDuration).repeatForever(autoreverses: false) : .default)
			}
			.font(.system(size: fontSize(for: size)))
			.cardify(isFaceUp: card.isFaceUp, colorGradient:colorGradient, cornerRadius: Constant.cornerRadius, strokeLineWidth: Constant.strokeLineWidth)
			.transition(AnyTransition.scale)
		}
	}
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let gameViewModel = EmojiMemoryGameViewModel()
		gameViewModel.choose(card: gameViewModel.cards[0])
        return EmojiMemoryGameView(viewModel: gameViewModel)
    }
}
