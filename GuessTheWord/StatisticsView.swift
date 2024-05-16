import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var gameState: GameState // Access the shared GameState object

    var body: some View {
        VStack {
            // Title for the statistics screen
            Text("Statistics")
                .font(.system(size: 50))
                .padding(.top, 40)
                .fontWeight(.bold)

            // Retrieve statistics from UserDefaults
            let gamesPlayed = UserDefaults.standard.integer(forKey: "gamesPlayed")
            let gamesWon = UserDefaults.standard.integer(forKey: "gamesWon")
            let totalGuesses = UserDefaults.standard.integer(forKey: "totalGuesses")
            let averageGuesses = gamesPlayed > 0 ? Double(totalGuesses) / Double(gamesPlayed) : 0.0

            // Display the statistics
            VStack(alignment: .leading, spacing: 15) {
                Text("Games Played: \(gamesPlayed)")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Text("Games Won: \(gamesWon)")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Text("Total Guesses: \(totalGuesses)")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Text(String(format: "Average Guesses: %.2f", averageGuesses))
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 25)

            Spacer() // Spacer to push content to the top
        }
        .padding(.top, 100)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView().environmentObject(GameState())
    }
}
