import SwiftUI

@main
struct GuessTheWordApp: App {
    @StateObject private var gameState = GameState() // Initialize the GameState object

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameState) // Provide the GameState object to the entire app
        }
    }
}
