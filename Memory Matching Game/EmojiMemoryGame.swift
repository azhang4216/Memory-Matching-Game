//
//  EmojiMemoryGame.swift
//  Memory Matching Game (View Model specific to emoji memory matching game)
//
//  Created by Angela Zhang on 3/19/25.
//

// view model has to include SwiftUI because it is packaging things up for the UI
// BUT is not going to be creating any Views
import SwiftUI

// is a class because will be shared amongst things
class EmojiMemoryGame: ObservableObject {
    // we need an init for classes, unlike structs.
    // this means we HAVE to have an instance assigned to these vars / lets:
    
    // NOTE: initializers are NOT IN ORDER.
    //       in order to make sure we have emojis array for our model init, we make it STATIC.
    //       static = global, but within the this scope -> no polluting outside namespace!
    //       global / static variables are initialized before other variables
    private static let emojis = [
        ["🚀", "🌍", "🌕", "🪐", "✨", "👨‍🚀", "🛸", "🛰️"],             // space
        ["🍕", "🍔", "🍎", "🍣", "🥗", "🍩", "🍹", "🍫", "🌮"],       // food
        ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🦁", "🐸", "🐧"]  // animals
    ]
    
    private let emojiThemeImgs = [
        "moon.stars.circle.fill",
        "fork.knife.circle.fill",
        "dog.circle.fill"
    ]
    
    // specified the "don't care" as String here
    // closure syntax ie. in-line functions
    // @Published tells our VM (ObservableObject) to trigger view updates when var changes
    @Published private var model: MemoryGame<String> = MemoryGame<String>(
        cardContentFactory: { (indexOfPair: Int, indexOfTheme: Int) -> String in
            if emojis[indexOfTheme].indices.contains(indexOfPair) {
                // since "emojis" is a STATIC variable inside our class,
                // we technically have to say EmojiMemoryGame.emojis, but
                // Swift is also smart enough to infer when we just say "emojis"
                return emojis[indexOfTheme][indexOfPair]
            } else {
                // something is out of index
                return "⁉️"
            }
        }
    )
    
    /* MARK: INTENT FUNCTIONS */
    func setTheme(_ themeIndex: Int) {
        model.theme = themeIndex
        
        // Create a new array of cards based on the selected theme
        let newCards: [MemoryGame<String>.Card] = (0..<model.numberOfPairsOfCards * 2).map { index in
            // Calculate pair index for both card positions in the pair
            let pairIndex = index / 2
            // Create a new card with the content for this pair and theme
            return MemoryGame<String>.Card(content: EmojiMemoryGame.emojis[model.theme][pairIndex])
        }
        
        // Replace the old cards with the newly created array of cards
        model.setCards(newCards)
    }
    
    func shuffleCards() {
        model.shuffle()
    }
    
    /* MARK: GETTER VARS / FUNCTIONS */
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeIndex: Int {
        return model.theme
    }
    
    var numOfThemes: Int {
        return EmojiMemoryGame.emojis.count
    }
    
    func emojiThemeImg(_ indexOfTheme: Int) -> String {
        return emojiThemeImgs[indexOfTheme]
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
