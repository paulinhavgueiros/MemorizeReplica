//
//  MemoryGameViewModel.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import SwiftUI

class MemoryGameViewModel {
    private var model: MemoryGame<String> = MemoryGameViewModel.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let numberOfPairs = Int.random(in: 2...5)
        var emojiBase = ["🎃", "💀", "👻", "🕷", "🧙🏼‍♀️", "🦩", "🐼", "🐻", "🐇", "❤️", "🐒", "🐎"]
        var cardContent = [String]()
        
        for _ in 0..<numberOfPairs {
            cardContent.append(emojiBase.remove(at: Int.random(in: 0..<emojiBase.count)))
        }

        return MemoryGame<String>(numberOfPairs: numberOfPairs) { index in
            cardContent[index]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
