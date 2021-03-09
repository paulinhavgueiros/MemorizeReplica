//
//  EmojiMemoryGameTheme.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 08/03/21.
//

import SwiftUI

struct EmojiMemoryGameTheme {
	
	// MARK: - Data Structure Declarations
	
	enum EmojiMemoryGameThemeName: String {
		case animals
		case nature
		case fruits
		case fashion
		case technology
		case faces
	}
	
	enum ColorType {
		case color(Color)
		case gradient(Gradient)
	}
	
	// MARK: - Properties
	
	var themeName: EmojiMemoryGameThemeName
	var name: String {
		return themeName.rawValue.capitalizingFirstLetter()
	}
	var emojiSet: [String]
	var numberOfPairs: Int?
	var mainColor: ColorType
	
	// MARK: - Initialization
	
	static func getRandomTheme() -> EmojiMemoryGameTheme {
		let randomThemeIndex = Int.random(in: 0..<themes.count)
		var newTheme = themes[randomThemeIndex]
		
		if newTheme.numberOfPairs == nil {
			newTheme.numberOfPairs = Int.random(in: 2...6)
		}
		return newTheme
	}
	
	// MARK: - Constant Class Properties
	
	static let defaultNumberOfPairs = 6
	
	static let themes: [EmojiMemoryGameTheme] = [
		EmojiMemoryGameTheme(themeName: .animals, emojiSet: ["🐻‍❄️", "🐶", "🐱", "🐯", "🦁", "🐷", "🐸", "🐹", "🦊", "🐰", "🐨", "🐮"], numberOfPairs: defaultNumberOfPairs, mainColor: .color(.orange)),
		EmojiMemoryGameTheme(themeName: .nature, emojiSet: ["🌵", "🪵", "🌴", "🍄", "🍁", "🌷", "🌻", "🍀", "🌱", "🐚", "🪨", "🪴"], numberOfPairs: defaultNumberOfPairs, mainColor: .color(.green)),
		EmojiMemoryGameTheme(themeName: .fruits, emojiSet: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥝"], numberOfPairs: defaultNumberOfPairs, mainColor: .gradient(Gradient(colors: [.blue, .green, .yellow]))),
		EmojiMemoryGameTheme(themeName: .fashion, emojiSet: ["👚", "👗", "🥿", "👠", "👡", "👢", "🧤", "🧣", "👒", "👜", "🕶", "👛"], numberOfPairs: defaultNumberOfPairs, mainColor: .gradient(Gradient(colors: [.pink, .purple]))),
		EmojiMemoryGameTheme(themeName: .technology, emojiSet: ["🎧", "🎮", "⌚️", "📱", "💻", "🖨", "🖱", "💽", "💾", "📼", "📷", "📹"], numberOfPairs: defaultNumberOfPairs, mainColor: .gradient(Gradient(colors: [.black, .gray]))),
		EmojiMemoryGameTheme(themeName: .faces, emojiSet: ["😁", "😂", "😇", "😌", "😍", "😋", "🤓", "🥳", "😒", "☹️", "😩", "🤗"], numberOfPairs: nil, mainColor: .gradient(Gradient(colors: [.purple, .blue])))
	]
}
