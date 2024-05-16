import SwiftUI

struct ModeSelectionView: View {
    @State private var selectedMode: GameMode? = nil // State to control the selected game mode

    var body: some View {
        VStack {
            // Title for the mode selection screen
            Text("Select Mode")
                .font(.system(size: 50))
                .padding()
                .fontWeight(.bold)

            // Navigation link for Classic Mode
            NavigationLink(destination: GameModeInstructionsView(mode: .classic).environmentObject(GameState()), tag: .classic, selection: $selectedMode) {
                Button(action: {
                    selectedMode = .classic // Set the selected mode to classic
                }) {
                    Text("Classic Mode")
                        .frame(maxWidth: 190)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 70)
            }

            // Navigation link for Timed Mode
            NavigationLink(destination: GameModeInstructionsView(mode: .timed).environmentObject(GameState()), tag: .timed, selection: $selectedMode) {
                Button(action: {
                    selectedMode = .timed // Set the selected mode to timed
                }) {
                    Text("Timed Mode")
                        .frame(maxWidth: 190)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct ModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectionView().environmentObject(GameState())
    }
}
