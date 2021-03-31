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
		case weather
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
	var color: ColorType
	
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
		EmojiMemoryGameTheme(
			themeName: .animals,
			emojiSet: ["🐻‍❄️", "🐶", "🐱", "🐯", "🦁", "🐷", "🐸", "🐹", "🦊", "🐰", "🐨", "🐮"],
			numberOfPairs: defaultNumberOfPairs,
			color: .color(.orange)),
		EmojiMemoryGameTheme(
			themeName: .nature,
			emojiSet: ["🌵", "🪵", "🌴", "🍄", "🍁", "🌷", "🌻", "🍀", "🌱", "🐚", "🪨", "🪴"],
			numberOfPairs: defaultNumberOfPairs,
			color: .color(.green)),
		EmojiMemoryGameTheme(
			themeName: .fruits,
			emojiSet: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥝"],
			numberOfPairs: defaultNumberOfPairs,
			color: .gradient(Gradient(colors: [.blue, .green, .yellow]))),
		EmojiMemoryGameTheme(
			themeName: .fashion,
			emojiSet: ["👚", "👗", "🥿", "👠", "👡", "👢", "🧤", "🧣", "👒", "👜", "🕶", "👛"],
			numberOfPairs: defaultNumberOfPairs,
			color: .gradient(Gradient(colors: [.pink, .purple]))),
		EmojiMemoryGameTheme(
			themeName: .technology,
			emojiSet: ["🎧", "🎮", "⌚️", "📱", "💻", "🖨", "🖱", "💽", "💾", "📼", "📷", "📹"],
			numberOfPairs: defaultNumberOfPairs,
			color: .gradient(Gradient(colors: [.gray, .black, .gray]))),
		EmojiMemoryGameTheme(
			themeName: .weather,
			emojiSet: ["☀️", "❄️", "💨", "🌤", "🌩", "🌈", "🌪", "💫", "☄️", "🔥", "💧", "☃️"],
			numberOfPairs: defaultNumberOfPairs,
			color: .gradient(Gradient(colors: [.yellow, .orange, .green]))),
		EmojiMemoryGameTheme(
			themeName: .faces,
			emojiSet: ["😁", "😂", "😇", "😌", "😍", "😋", "🤓", "🥳", "😒", "☹️", "😩", "🤗"],
			numberOfPairs: nil,
			color: .gradient(Gradient(colors: [.purple, .blue])))
	]
}
