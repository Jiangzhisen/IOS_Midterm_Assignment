//
//  EmojiMemoryGameView.swift
//  Memorize10944128
//
//  Created by 中原資管 on 2023/3/6.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Theme: \(game.themeName)").font(.largeTitle).foregroundColor(.blue).padding(.bottom)
                Text("Score: \(game.score)").font(.title).foregroundColor(.blue)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card, theme: game.theme)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                newGame.padding(.top)
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
    
    var newGame: some View {
        Button(action: {
            game.newGame()
        }) {
            VStack {
                Image(systemName: "repeat.circle").font(.largeTitle)
                Spacer()
                Text("New Game").font(.title)
            }
            .foregroundColor(.blue)
        }
    }
}


struct CardView: View {
    var card: EmojiMemoryGame.Card
    var theme: EmojiMemoryGame.Theme
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(theme.color)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(theme.color)
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
