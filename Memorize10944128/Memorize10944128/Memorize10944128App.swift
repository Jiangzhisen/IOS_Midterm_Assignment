//
//  Memorize10944128App.swift
//  Memorize10944128
//
//  Created by 中原資管 on 2023/3/6.
//

import SwiftUI

@main
struct Memorize10944128App: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}

