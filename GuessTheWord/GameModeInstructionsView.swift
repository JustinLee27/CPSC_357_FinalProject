import SwiftUI

struct GameModeInstructionsView: View {
    @EnvironmentObject var gameState: GameState // Access the shared GameState object
    let mode: GameMode // The selected game mode
    @State private var navigateToGameView = false // State to control navigation to the game view

    var body: some View {
        VStack {
            // Display the mode title (Classic Mode or Timed Mode)
            Text(mode == .classic ? "Classic Mode" : "Timed Mode")
                .font(.system(size: 50))
                .padding()
                .fontWeight(.bold)

            // Display the mode instructions
            Text(mode == .classic ? "In Classic Mode, you have unlimited time to guess the word. Try to guess the word with the fewest attempts possible." : "In Timed Mode, you have 60 seconds to guess the word. Try to guess the word before time runs out!")
                .padding(.top, 50)
                .padding(.horizontal, 50)

            // Button to navigate to the game view
            Button(action: {
                navigateToGameView = true
            }) {
                Text("Play")
                    .frame(maxWidth: 250)
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 100)
            }
            .padding()

            // Navigation link to GameView, activated by the play button
            NavigationLink(destination: GameView(mode: mode).environmentObject(gameState), isActive: $navigateToGameView) {
                EmptyView()
            }
        }
    }
}

struct GameModeInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeInstructionsView(mode: .classic).environmentObject(GameState())
    }
}
