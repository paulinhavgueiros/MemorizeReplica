//
//  EmojiMemoryGameViewModel.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] { model.cards }
    var score: Int { model.score }
    
    // MARK: - Type Properties
    
    private static var offset = 0
    
	// MARK: - Instance Properties
	
    @Published private var model: MemoryGame<String>
	var theme: EmojiMemoryGameTheme
	
	// MARK: - Initialization
	
	init() {
        theme = EmojiMemoryGameTheme.getRandomTheme()
		model = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
	}
	
	private static func createMemoryGame(with theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        // increment offset for following game
        defer {
            offset += theme.numberOfPairs!*2
        }
        
		let emojiBase = theme.emojiSet.shuffled()
        return MemoryGame<String>(numberOfPairs: theme.numberOfPairs!, offset: offset) { index in
            emojiBase[index]
        }
    }

    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
	
	func startNewGame() {
		theme = EmojiMemoryGameTheme.getRandomTheme()
		model = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
	}
}
