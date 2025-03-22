//
//  Memory_Matching_GameApp.swift
//  Memory Matching Game
//
//  Created by Angela Zhang on 3/10/25.
//

import SwiftUI

@main
struct Memory_Matching_GameApp: App {
    @StateObject private var viewModel = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: viewModel)
        }
    }
}
