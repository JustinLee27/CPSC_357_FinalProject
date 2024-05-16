import Foundation
import Combine

class GameState: ObservableObject {
    // Published properties to update the UI when they change
    @Published var guess: String = ""
    @Published var guessedWords: [(word: String, feedback: String)] = []
    @Published var showVictoryScreen: Bool = false
    @Published var showTimedOutScreen: Bool = false
    @Published var remainingTime: Int = 60
    @Published var navigateToGameView: Bool = false
    @Published var navigateToMainMenu: Bool = false
    @Published var navigateToModeSelection: Bool = false

    // List of possible target words
    let words: [String] = [
        "apple", "grape", "pearl", "stone", "brick", "crane", "flame",
        "globe", "horse", "knock", "light", "mango", "night", "queen",
        "robot", "snake", "table", "uncle", "vivid", "whale", "xenon",
        "yacht", "zebra", "alpha", "bravo", "charm", "delta", "eagle",
        "fable", "giant", "haste", "image", "jolly", "kiosk", "lemon",
        "mercy", "noble", "oasis", "piano", "quilt", "raven", "salad",
        "tempo", "urban", "vapor", "woven", "yield", "zesty", "abide",
        "bloom", "chase", "drape", "elite", "frail", "glint", "hinge",
        "ivory", "jewel", "kneel", "lunar", "mirth", "nerve", "otter",
        "plead", "quest", "reign", "slope", "twine", "umbra", "verse",
        "waste", "yearn", "zonal", "azure", "bacon", "cargo", "dough",
        "ember", "frost", "gravy", "hatch", "irate", "jolly", "kayak",
        "leech", "mirth", "noisy", "ocean", "peace", "quiet", "rapid",
        "sheep", "tower", "unity", "vaunt", "wager", "xenon", "yacht",
        "zebra"
    ]
    
    var targetWord: String // The word to be guessed
    var timer: AnyCancellable? // Timer for timed mode

    init() {
        self.targetWord = words.randomElement()! // Initialize with a random word
        loadStatistics() // Load saved statistics
    }

    // Process the submitted guess
    func submitGuess() {
        if guess.count == 5 {
            let feedback = getFeedback(for: guess)
            guessedWords.append((word: guess, feedback: feedback))
            if guess.lowercased() == targetWord.lowercased() {
                showVictoryScreen = true
                updateStatistics(didWin: true)
                timer?.cancel()
            }
            guess = ""
        }
    }

    // Generate feedback for the submitted guess
    func getFeedback(for guess: String) -> String {
        var feedback = ""
        let lowercasedGuess = guess.lowercased()
        let lowercasedTargetWord = targetWord.lowercased()

        for (gChar, tChar) in zip(lowercasedGuess, lowercasedTargetWord) {
            if gChar == tChar {
                feedback.append("🟩") // Correct letter and position
            } else if lowercasedTargetWord.contains(gChar) {
                feedback.append("🟨") // Correct letter, wrong position
            } else {
                feedback.append("⬜️") // Wrong letter
            }
        }
        return feedback
    }

    // Update the game statistics
    func updateStatistics(didWin: Bool) {
        var gamesPlayed = UserDefaults.standard.integer(forKey: "gamesPlayed")
        var gamesWon = UserDefaults.standard.integer(forKey: "gamesWon")
        var totalGuesses = UserDefaults.standard.integer(forKey: "totalGuesses")

        gamesPlayed += 1
        if didWin { gamesWon += 1 }
        totalGuesses += guessedWords.count

        UserDefaults.standard.set(gamesPlayed, forKey: "gamesPlayed")
        UserDefaults.standard.set(gamesWon, forKey: "gamesWon")
        UserDefaults.standard.set(totalGuesses, forKey: "totalGuesses")
    }

    // Reset the game state for a new game
    func resetGame() {
        guess = ""
        guessedWords = []
        showVictoryScreen = false
        showTimedOutScreen = false
        remainingTime = 60
        targetWord = words.randomElement()!
        timer?.cancel()
    }

    // Start the countdown timer for timed mode
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                self.remainingTime -= 1
                if self.remainingTime <= 0 {
                    self.timer?.cancel()
                    self.showTimedOutScreen = true
                }
            }
    }

    // Handle giving up in the timed mode
    func giveUp() {
        showTimedOutScreen = true
        updateStatistics(didWin: false)
        timer?.cancel()
        remainingTime = 0
    }

    // Reset navigation states
    func resetNavigation() {
        navigateToGameView = false
        navigateToMainMenu = false
        navigateToModeSelection = false
    }

    // Load saved statistics
    func loadStatistics() {
        let gamesPlayed = UserDefaults.standard.integer(forKey: "gamesPlayed")
        let gamesWon = UserDefaults.standard.integer(forKey: "gamesWon")
        let totalGuesses = UserDefaults.standard.integer(forKey: "totalGuesses")
        print("Statistics loaded: Games Played: \(gamesPlayed), Games Won: \(gamesWon), Total Guesses: \(totalGuesses)")
    }
}
