//
//  EmojiMemoryGameViewModel.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    // MARK: - Type Properties
    
    private static var offset = 0
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] { model.cards }
    var score: Int { model.score }

	// MARK: - Instance Properties
	
    @Published private var model: MemoryGame<String>
    @Published var cardIsHiddenByID: [Int: Bool]
	var theme: EmojiMemoryGameTheme
	
	// MARK: - Initialization
	
	init() {
        theme = EmojiMemoryGameTheme.getRandomTheme()
        
        let gameModel = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
        model = gameModel
        
        cardIsHiddenByID = gameModel.cards.reduce([Int: Bool]()) { (dictionary, card) -> [Int: Bool] in
            var dictionary = dictionary
            dictionary[card.id] = true
            return dictionary
        }
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
    
    func show(card: MemoryGame<String>.Card) {
        cardIsHiddenByID[card.id] = false
    }
	
	func startNewGame() {
        theme = EmojiMemoryGameTheme.getRandomTheme()
        model = EmojiMemoryGameViewModel.createMemoryGame(with: theme)
        
        cardIsHiddenByID = model.cards.reduce([Int: Bool]()) { (dictionary, card) -> [Int: Bool] in
            var dictionary = dictionary
            dictionary[card.id] = true
            return dictionary
        }
    }
}
