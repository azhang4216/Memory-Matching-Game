//
//  MemorizeGame.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/19/25.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    // this practice is good for namespacing
    // just want this Card struct to be specific to our MemoryGame
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent // don't care type... specified when MemoryGame used
    }
}
