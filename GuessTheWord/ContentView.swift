import SwiftUI

struct ContentView: View {
    // State to control navigation to the mode selection view
    @State private var navigateToModeSelection = false

    var body: some View {
        NavigationView {
            VStack {
                // Title of the app
                Text("Word Quest")
                    .font(.system(size: 50))
                    .padding(.top, 40)
                    .fontWeight(.bold)

                // Button to start the game, navigates to ModeSelectionView
                Button(action: {
                    navigateToModeSelection = true
                }) {
                    Text("Start Game")
                        .padding()
                        .frame(maxWidth: 250)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                }

                // Navigation link to ModeSelectionView, activated by the start game button
                NavigationLink(destination: ModeSelectionView().environmentObject(GameState()), isActive: $navigateToModeSelection) {
                    EmptyView()
                }

                // Button to navigate to HowToPlayView
                NavigationLink(destination: HowToPlayView()) {
                    Text("How To Play")
                        .padding()
                        .frame(maxWidth: 250)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 25)
                }

                // Horizontal stack for settings and statistics buttons
                HStack(spacing: 50) {
                    // Button to navigate to SettingsView
                    NavigationLink(destination: SettingsView()) {
                        VStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.blue)
                            Text("Settings")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                    }

                    // Button to navigate to StatisticsView
                    NavigationLink(destination: StatisticsView()) {
                        VStack {
                            Image(systemName: "chart.bar.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.blue)
                            Text("Statistics")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                    }
                }
                .padding(.top, 25)

                Spacer() // Spacer to push content to the top
            }
            .padding(.top, 150)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameState())
    }
}
