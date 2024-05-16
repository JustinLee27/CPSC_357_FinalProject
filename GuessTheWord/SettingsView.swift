import SwiftUI

struct SettingsView: View {
    @State private var showResetAlert: Bool = false // State to control the display of the reset alert

    var body: some View {
        VStack {
            // Title for the settings screen
            Text("Settings")
                .font(.system(size: 50))
                .padding(.top, 40)
                .fontWeight(.bold)

            VStack(spacing: 20) {
                // Button to reset statistics
                Button("Reset Statistics") {
                    showResetAlert = true // Show the reset alert when the button is tapped
                }
                .font(.title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .alert(isPresented: $showResetAlert) {
                    Alert(
                        title: Text("Reset Statistics"),
                        message: Text("Are you sure you want to reset all statistics? This action cannot be undone."),
                        primaryButton: .destructive(Text("Reset")) {
                            resetStatistics() // Call the resetStatistics function if the reset button is tapped
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding(.top, 40)

            Spacer() // Spacer to push content to the top
        }
        .padding(.top, 100)
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)) // Background color
    }

    // Function to reset statistics in UserDefaults
    private func resetStatistics() {
        UserDefaults.standard.set(0, forKey: "gamesPlayed")
        UserDefaults.standard.set(0, forKey: "gamesWon")
        UserDefaults.standard.set(0, forKey: "totalGuesses")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
