import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameState: GameState // Access the shared GameState object
    let mode: GameMode // The selected game mode
    @State private var navigateToVictory = false // State to control navigation to the victory view

    init(mode: GameMode) {
        self.mode = mode
    }

    var body: some View {
        VStack {
            // Title for the game view
            Text("Guess the word!")
                .font(.system(size: 40))
                .padding()
                .fontWeight(.bold)

            // Display remaining time if in timed mode
            if mode == .timed {
                Text("Time remaining: \(gameState.remainingTime) seconds")
                    .font(.subheadline)
                    .padding()
            }

            // Text field for entering guesses
            TextField("Enter your guess", text: $gameState.guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .onChange(of: gameState.guess) { newValue in
                    if newValue.count > 5 {
                        gameState.guess = String(newValue.prefix(5))
                    }
                }
                .onSubmit {
                    gameState.submitGuess()
                    if gameState.showVictoryScreen {
                        navigateToVictory = true
                    }
                }

            // Button to submit the guess
            Button("Submit Guess") {
                gameState.submitGuess()
                if gameState.showVictoryScreen {
                    navigateToVictory = true
                }
            }
            .frame(maxWidth: 250)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            // List of guessed words with feedback
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack {
                        ForEach(gameState.guessedWords.indices, id: \.self) { index in
                            HStack {
                                ForEach(0..<gameState.guessedWords[index].word.count, id: \.self) { charIndex in
                                    let char = gameState.guessedWords[index].word[charIndex]
                                    let feedback = gameState.guessedWords[index].feedback[charIndex]
                                    Text(String(char))
                                        .frame(width: 40, height: 40)
                                        .background(colorForFeedback(feedback))
                                        .cornerRadius(5)
                                        .padding(2)
                                }
                            }
                            .id(index) // Set the ID for each row
                        }
                    }
                }
                .onChange(of: gameState.guessedWords.count) { _ in
                    // Scroll to the latest guess
                    withAnimation {
                        scrollViewProxy.scrollTo(gameState.guessedWords.indices.last, anchor: .bottom)
                    }
                }
            }
            .frame(maxHeight: 300)

            // Button to give up in timed mode
            if mode == .timed {
                Button(action: {
                    gameState.giveUp()
                }) {
                    Text("Give Up")
                        .frame(maxWidth: 250)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            } else {
                // Button to navigate to the main menu
                Button(action: {
                    gameState.navigateToMainMenu = true
                }) {
                    Text("Main Menu")
                        .frame(maxWidth: 250)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }

            // Navigation links to other views
            NavigationLink(destination: ContentView().environmentObject(gameState).onAppear {
                gameState.resetNavigation()
            }.navigationBarBackButtonHidden(true), isActive: $gameState.navigateToMainMenu) {
                EmptyView()
            }

            NavigationLink(destination: VictoryView().environmentObject(gameState).navigationBarBackButtonHidden(true), isActive: $navigateToVictory) {
                EmptyView()
            }

            NavigationLink(destination: ModeSelectionView().environmentObject(gameState).onAppear {
                gameState.resetNavigation()
            }.navigationBarBackButtonHidden(true), isActive: $gameState.navigateToModeSelection) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if mode == .timed {
                gameState.startTimer()
            }
        }
        .alert(isPresented: $gameState.showTimedOutScreen) {
            Alert(
                title: Text("Time's Up!"),
                message: Text("The word was \(gameState.targetWord). Better luck next time!"),
                primaryButton: .default(Text("Play Again")) {
                    gameState.resetGame()
                    gameState.navigateToModeSelection = true
                },
                secondaryButton: .cancel(Text("Main Menu")) {
                    gameState.resetGame()
                    gameState.navigateToMainMenu = true
                }
            )
        }
    }

    // Helper function to determine feedback color
    private func colorForFeedback(_ feedback: Character) -> Color {
        switch feedback {
        case "🟩":
            return .green
        case "🟨":
            return .yellow
        case "⬜️":
            return .gray
        default:
            return .gray
        }
    }
}

// Extension to allow character indexing in strings
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(mode: .classic).environmentObject(GameState())
    }
}
