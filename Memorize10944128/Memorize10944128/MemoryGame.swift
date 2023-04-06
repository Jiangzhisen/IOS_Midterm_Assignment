//
//  MemoryGame.swift
//  Memorize10944128
//
//  Created by 中原資管 on 2023/3/20.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards:Array<Card>
    
    private(set) var score: Int
    
    private var lastFaceUpIndex: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach({ cards[$0].isFaceUp = $0 == newValue }) }
    }
    
    mutating func choose(card: Card) {
        if let cardIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[cardIndex].isFaceUp,
            !cards[cardIndex].isMatched {
            if let lastIndex = lastFaceUpIndex {
                if cards[lastIndex].content == card.content {
                    cards[lastIndex].isMatched = true
                    cards[cardIndex].isMatched = true
                    score += 2
                } else {
                    cards[cardIndex].hasBeenOpened == true ? score -= 1 : cards[cardIndex].hasBeenOpened.toggle()
                    cards[lastIndex].hasBeenOpened == true ? score -= 1 : cards[lastIndex].hasBeenOpened.toggle()
                }
                cards[cardIndex].isFaceUp = true
            }
            else {
                lastFaceUpIndex = cardIndex
            }
        }
        
        print("cards:\(cards)")
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairs {
            let content: CardContent = createCardContent(index)
            cards.append(Card(content: content, id: 2 * index))
            cards.append(Card(content: content, id: 2 * index+1))
        }
        
        // todo: add numberOfPairs's card
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: Int
        var hasBeenOpened: Bool = false
    }
}

extension Array {
    var oneAndOnly: Element? { count == 1 ? first : nil }
}



struct ThemePool<ThemeContent> {
    private(set) var themes:Array<Theme>
    
    init() {
        themes = Array<Theme>()
    }
    
    struct Theme: Identifiable {
        var name: String
        var color: Color
        var numberOfPairs: Int
        var items: Array<ThemeContent>
        let id: Int
    }
    
    mutating func addTheme(name: String, color: Color, numberOfPairs: Int, items: Array<ThemeContent>, id: Int) {
        themes.append(Theme(name: name, color: color, numberOfPairs: numberOfPairs, items: items, id: id))
    }
    
}








