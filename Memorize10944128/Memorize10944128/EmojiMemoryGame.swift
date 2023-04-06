//
//  EmojiMemoryGame.swift
//  Memorize10944128
//
//  Created by 中原資管 on 2023/3/20.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    typealias Theme = ThemePool<String>.Theme
    
    static private var themePool: ThemePool<String> = ThemePool<String>()
    
    private(set) var theme: Theme
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String>{
        let shuffledItems = theme.items.shuffled()
        return MemoryGame<String>(numberOfPairs: theme.numberOfPairs) { index in
            shuffledItems[index]
        }
    }
    
    static func createThemePool() -> ThemePool<String>{
        self.themePool.addTheme(name: "Animals", color: .red, numberOfPairs: 6, items: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐥", "🦆", "🦅", "🦉", "🐴"], id: 1)
        self.themePool.addTheme(name: "Food", color: .orange, numberOfPairs: 7, items: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌽"], id: 2)
        self.themePool.addTheme(name: "Activity", color: .yellow, numberOfPairs: 8, items: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🥅", "⛳️", "🪁", "🛝", "🏹", "🎣", "🤿", "🥊", "🛹", "🛼"], id: 3)
        self.themePool.addTheme(name: "travel", color: .green, numberOfPairs: 6, items: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🚲", "🛵", "🏍️", "🛺", "🚃", "🚋", "🚝", "🚈", "🚂", "✈️"], id: 4)
        self.themePool.addTheme(name: "Item", color: .blue, numberOfPairs: 7, items: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "💽", "📷", "☎️", "🎙", "🎚", "🧭", "⏱", "⏳", "📡", "🔋", "💡", "🔦", "🧯", "🛢", "💳"], id: 5)
        self.themePool.addTheme(name: "flag", color: .purple, numberOfPairs: 8, items: ["🇺🇳", "🇹🇹", "🇹🇷", "🇹🇨", "🇹🇲", "🇧🇹", "🇨🇫", "🇨🇳", "🇩🇰", "🇪🇨", "🇪🇷", "🇵🇬", "🇧🇷", "🇧🇧", "🇵🇾", "🇧🇭", "🇧🇸", "🇵🇦", "🇵🇸", "🇵🇰", "🇯🇵", "🇧🇪", "🇯🇲", "🇮🇱"], id: 6)
        return self.themePool
    }
    
    @Published private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairs: 0) { _ in "" }
    
    init() {
        EmojiMemoryGame.themePool = EmojiMemoryGame.createThemePool()
        theme = EmojiMemoryGame.themePool.themes[Int.random(in: 0..<EmojiMemoryGame.themePool.themes.count)]
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        return theme.name
    }
    
    // MARK: - View Operations
    
    func choose(_ card: Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themePool.themes[Int.random(in: 0..<EmojiMemoryGame.themePool.themes.count)]
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

}
