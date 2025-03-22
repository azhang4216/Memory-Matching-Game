//
//  MemorizeGame.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/19/25.
//

import Foundation

struct MemoryGame<CardContent> {
    // only this code (not other references to this model) can SET cards
    // but, viewing these cards is public
    private(set) var cards: Array<Card>
    var theme: Int = 0
    var numberOfPairsOfCards: Int = 4
    
    // inits for structs: we can have multiple, can take different arguments
    init(cardContentFactory: (Int, Int) -> CardContent) {
        cards = Array<Card>()    // can also do [], [Card]()... same thing
        
        // add numberOfPairsOfCards x 2 cards to the array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex, theme)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func setCards(_ newCards: Array<Card>) {
        cards = newCards
    }
    
    // this practice is good for namespacing
    // just want this Card struct to be specific to our MemoryGame
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // don't care type... specified when MemoryGame used
    }
}
