import SwiftUI

struct VictoryView: View {
    @EnvironmentObject var gameState: GameState // Access the shared GameState object
    @State private var navigateToModeSelection = false // State to control navigation to the mode selection view
    @State private var navigateToMainMenu = false // State to control navigation to the main menu

    var body: some View {
        VStack {
            // Title for the victory screen
            Text("Congratulations!")
                .font(.system(size: 40))
                .padding(.top, 110)
                .fontWeight(.bold)

            // Display victory message
            Text("You guessed the word in")
                .font(.title)
                .padding()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()

            // Display number of attempts
            Text("\(gameState.guessedWords.count)")
                .font(.system(size: 70))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()

            // Display completion message
            Text("attempts!")
                .font(.title)
                .padding()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()

            // Button to play again, navigates to ModeSelectionView
            Button(action: {
                gameState.resetGame()
                navigateToModeSelection = true
            }) {
                Text("Play Again")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)

            // Button to navigate to the main menu
            Button(action: {
                gameState.resetGame()
                navigateToMainMenu = true
            }) {
                Text("Main Menu")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)

            // Navigation link to ModeSelectionView, activated by the play again button
            NavigationLink(destination: ModeSelectionView().environmentObject(gameState).onAppear {
                gameState.resetNavigation()
            }.navigationBarBackButtonHidden(true), isActive: $navigateToModeSelection) {
                EmptyView()
            }

            // Navigation link to ContentView (main menu), activated by the main menu button
            NavigationLink(destination: ContentView().environmentObject(gameState).onAppear {
                gameState.resetNavigation()
            }.navigationBarBackButtonHidden(true), isActive: $navigateToMainMenu) {
                EmptyView()
            }

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView().environmentObject(GameState())
    }
}
