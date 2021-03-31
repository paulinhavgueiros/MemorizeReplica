//
//  MemoryGame.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 18/02/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
	private(set) var score: Int = 0
    private(set) var cards: [Card] // setting is private, reading not (VM needs to read)
	private var indexOfOnlyFaceUpCard: Int? {
		get { cards.indices.filter{ cards[$0].isFaceUp }.only() }
		set {
			for index in 0..<cards.count {
				cards[index].isFaceUp = index == newValue
			}
		}
	}
    
    init(numberOfPairs: Int, offset: Int, cardGenerator: (Int) -> CardContent) {
        cards = [Card]()
        for index in 0..<numberOfPairs {
            let content = cardGenerator(index)
            cards.append(Card(content: content, id: index*2 + offset))
            cards.append(Card(content: content, id: index*2+1 + offset))
        }
        cards.shuffle()
    }
    
    mutating func turnCardsDown() {
        indexOfOnlyFaceUpCard = nil
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
	
	// MARK: - Card
	
	struct Card: Identifiable {
		var isFaceUp: Bool = false {
			didSet {
				if isFaceUp { startUsingBonusTime() }
				else { stopUsingBonusTime() }
			}
		}
		var isMatched: Bool = false {
			didSet { stopUsingBonusTime() }
		}
		var hasBeenSeen: Bool = false
		var content: CardContent
		var id: Int
		
		// MARK: - Bonus Time
		/// It gives bonus points if user matches the card before a certain amount of time during which the card is face up
		
		// can be zero which means "no bonus available" for this card
		var bonusTimeLimit: TimeInterval = 6
		
		// how long this card has even been face up
		private var faceUpTime: TimeInterval {
			if let lastFaceUpDate = self.lastFaceUpDate {
				return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
			} else {
				return pastFaceUpTime
			}
		}
		
		// the last time this card was turned up (and is still face up)
		var lastFaceUpDate: Date?
		
		// the accumulated time this card has been face up in the past
		/// not incuding the current time it's been face up if it is currently so
		var pastFaceUpTime: TimeInterval = 0
		
		// how much time left before the bonus opportunity runs out
		var bonusTimeRemaining: TimeInterval {
			max(0, bonusTimeLimit - faceUpTime)
		}
		
		// % of the bonus time remaining
		var bonusRemaining: Double {
			(bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
		}
		
		// whether the card was matched during the bonus time period
		var hasEarnedBonus: Bool {
			isMatched && bonusTimeRemaining > 0
		}
		
		// whether we are currently face up, unmatched and have not yet used up the bonus window
		var isConsumingBonusTime: Bool {
			isFaceUp && !isMatched && bonusTimeRemaining > 0
		}
		
		// called when the card transitions to face up state
		private mutating func startUsingBonusTime() {
			if isConsumingBonusTime, lastFaceUpDate == nil {
				lastFaceUpDate = Date()
			}
		}
		
		// called when the card goes back face down (or gets matched)
		private mutating func stopUsingBonusTime() {
			pastFaceUpTime = faceUpTime
			lastFaceUpDate = nil
		}
	}
}
