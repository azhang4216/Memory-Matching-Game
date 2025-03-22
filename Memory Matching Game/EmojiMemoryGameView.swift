//
//  EmojiMemoryGameView.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/10/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    /* DECLARATIVE VARIABLES */
    @ObservedObject var viewModel: EmojiMemoryGame
    
    /* MAIN BODY */
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            themeSelector
            ScrollView {
                cardsView
            }
            shuffleButton
        }
        .padding()
    }
    
    /* HELPER STRUCTS & FUNCTIONS */
    
    var themeSelector: some View {
        HStack {
            ForEach(0..<viewModel.numOfThemes, id: \.self) { index in
                themeButton(assignedThemeInd: index)
                if index < viewModel.numOfThemes - 1 {
                    Spacer()
                }
            }
        }
        .font(.largeTitle)
        .padding()
    }
    
    func themeButton(assignedThemeInd: Int) -> some View {
        Button(action: {
            viewModel.setTheme(assignedThemeInd)
        }, label: {
            VStack {
                Image(systemName: viewModel.emojiThemeImg(assignedThemeInd))
                Text("Theme \(assignedThemeInd + 1)")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        })
        .disabled(assignedThemeInd == viewModel.themeIndex)
    }
    
    var cardsView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
//                        flipCard(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
    var shuffleButton: some View {
        Button(action: {
            viewModel.shuffleCards()
        }, label: {
            Text("Shuffle")
        })
    }
}

struct CardView: View {
    // using ViewModel
    let card: MemoryGame<String>.Card
    
    // customizing init to have no external name
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if card.isFaceUp {
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(card.content).font(.largeTitle)
                }
            } else {
                base.fill(.orange)
            }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
