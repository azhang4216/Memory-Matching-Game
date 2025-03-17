//
//  ContentView.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🥳", "🦐", "⛳️", "🦎", "😴", "😄", "😃", "⛔", "🎠", "🚓", "🚇"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    // we don't need cards, card adder, and remover, etc. to be its own structs,
    // since it only will be in scope / used here in the ContentView.
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .font(.largeTitle)
        .imageScale(.large)
    }
    
    var cards: some View {
        // LazyVGrid's columns is not Int, but array of GridItems.
        // if I want 3 columns: [GridItem(), GridItem(), GridItem()]
        // if I want a certain size for each grid item:
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder: some View {
        cardAdjuster(by: 1, symbol: "rectangle.fill.badge.plus")
    }
    
    var cardRemover: some View {
        cardAdjuster(by: -1, symbol: "rectangle.fill.badge.minus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            
            // the front of the card
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            // the back of the card
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
