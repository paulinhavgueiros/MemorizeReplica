//
//  MemoryGame.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
		var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
    
	var score: Int = 0
    var cards: [Card]
	var indexOfOnlyFaceUpCard: Int? {
		get { cards.indices.filter{ cards[$0].isFaceUp }.only() }
		set {
			for index in 0..<cards.count {
				cards[index].isFaceUp = index == newValue
			}
		}
	}
    
    init(numberOfPairs: Int, cardGenerator: (Int) -> CardContent) {
        cards = [Card]()
        for index in 0..<numberOfPairs {
            let content = cardGenerator(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2+1))
        }
        cards.shuffle()
    }
	
	/* Extra Credit 2 */
	
	var lastFaceUpDate: Date?
	var multiplier: Int = 1
	
    mutating func choose(card: Card) {
		if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp {
			if let lastFaceUpDate = lastFaceUpDate {
				multiplier = max(10 - Int(Date().timeIntervalSince(lastFaceUpDate)), 1)
			}
			
			if let potentialMatchingIndex = indexOfOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchingIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchingIndex].isMatched = true
					score += 2*multiplier
					
				} else {
					if cards[chosenIndex].hasBeenSeen == true { score -= 1*multiplier }
					if cards[potentialMatchingIndex].hasBeenSeen == true { score -= 1*multiplier }
				}
				cards[chosenIndex].isFaceUp = true
				
			} else {
				for index in cards.indices.filter({ cards[$0].isFaceUp }) {
					cards[index].hasBeenSeen = true
				}
				indexOfOnlyFaceUpCard = chosenIndex
			}
			lastFaceUpDate = Date()
		}
    }
}
