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
class EmojiMemoryGame {
    // specified the "don't care" as String here
    var gameModel: MemoryGame<String>
}
