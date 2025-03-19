//
//  ContentView.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    /* DECLARATIVE VARIABLES */
    @State var emojis = [
        ["🚀", "🌍", "🌕", "🪐", "✨", "👨‍🚀", "🛸", "🛰️"],             // space
        ["🍕", "🍔", "🍎", "🍣", "🥗", "🍩", "🍹", "🍫", "🌮"],       // food
        ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🦁", "🐸", "🐧"]  // animals
    ]
    
    let emojiThemeImgs = [
        "moon.stars.circle.fill",
        "fork.knife.circle.fill",
        "dog.circle.fill"
    ]
    
    @State private var themeInd = 0
    @State private var pairCount = 4
    @State private var cards: [Card] = []
    
    /* MAIN BODY */
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            themeSelector
            ScrollView {
                cardsView
            }
//            Spacer()
//            pairCountAdjusters
        }
        .padding()
//        .onAppear {
//            generateCards()
//        }
    }
    
    /* HELPER STRUCTS & FUNCTIONS */
    
    var themeSelector: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                themeButton(assignedThemeInd: index)
                if index < emojis.count - 1 {
                    Spacer()
                }
            }
        }
        .font(.largeTitle)
        .padding()
    }
    
    func themeButton(assignedThemeInd: Int) -> some View {
        Button(action: {
            themeInd = assignedThemeInd
//            generateCards()
        }, label: {
            VStack {
                Image(systemName: emojiThemeImgs[assignedThemeInd])
                Text("Theme \(assignedThemeInd + 1)")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        })
        .disabled(assignedThemeInd == themeInd)
    }
    
    var cardsView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
//                        flipCard(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
//    var pairCountAdjusters: some View {
//        HStack {
//            pairRemover
//            Spacer()
//            pairAdder
//        }
//        .font(.largeTitle)
//        .imageScale(.large)
//    }
//    
//    func pairAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            pairCount += offset
//            generateCards()
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(pairCount + offset < 1 || pairCount + offset > emojis[themeInd].count)
//    }
//    
//    var pairAdder: some View {
//        pairAdjuster(by: 1, symbol: "rectangle.fill.badge.plus")
//    }
//    
//    var pairRemover: some View {
//        pairAdjuster(by: -1, symbol: "rectangle.fill.badge.minus")
//    }
//    
//    func generateCards() {
//        let selectedEmojis = emojis[themeInd].prefix(pairCount)
//        let newCards = selectedEmojis.flatMap { [Card(content: $0), Card(content: $0)] }.shuffled()
//        
//        // Preserve existing face-up states
//        var updatedCards: [Card] = []
//        for card in newCards {
//            if let existingCard = cards.first(where: { $0.content == card.content && $0.isFaceUp }) {
//                updatedCards.append(Card(content: existingCard.content, isFaceUp: true))
//            } else {
//                updatedCards.append(card)
//            }
//        }
//        
//        cards = updatedCards
//    }
//    
//    func flipCard(_ card: Card) {
//        if let index = cards.firstIndex(where: { $0.id == card.id }) {
//            cards[index].isFaceUp.toggle()
//        }
//    }
}


struct Card: Identifiable {
    let id = UUID()
    let content: String
    var isFaceUp: Bool = false
}

struct CardView: View {
    let card: Card
    
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

//struct CardView: View {
//    let card: Card
//    
//    var body: some View {
//        ZStack() {
//            let base = RoundedRectangle(cornerRadius: 12)
//            
//            // the front of the card
//            Group {
//                base.fill(.white)
//                base.strokeBorder(lineWidth: 2)
//                Text(card.content).font(.largeTitle)
//            }
//            .opacity(card.isFaceUp ? 1 : 0)
//            
//            // the back of the card
//            base.fill(.orange)
//                .opacity(card.isFaceUp ? 0 : 1)
//        }
//        .onTapGesture {
//            card.isFaceUp.toggle()
//        }
//    }
//}

#Preview {
    ContentView()
}
