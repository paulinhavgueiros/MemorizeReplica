//
//  EmojiMemoryGameViewModel.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
	// MARK: - Instance Properties
	
    @Published private var model: MemoryGame<String>
	var theme: EmojiMemoryGameTheme = EmojiMemoryGameTheme.getRandomTheme()
	
	// MARK: - Initialization
	
	init() {
		model = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
	}
	
	private static func createMemoryGame(with theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
		let emojiBase = theme.emojiSet.shuffled()
        return MemoryGame<String>(numberOfPairs: theme.numberOfPairs!) { index in
            emojiBase[index]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] { model.cards }
	var score: Int { model.score }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
	
	func startNewGame() {
		theme = EmojiMemoryGameTheme.getRandomTheme()
		model = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
	}
}
