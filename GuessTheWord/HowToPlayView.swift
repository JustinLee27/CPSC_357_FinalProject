import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Title for the How To Play screen
                Text("How to Play")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                    .bold()

                // Introduction to the game
                Text("Welcome to Word Quest! Here’s a brief overview of the game modes available:")
                    .padding(.bottom, 10)

                // Section for rules applicable to both modes
                Text("Both Modes")
                    .font(.title2)
                    .padding(.bottom, 5)
                    .bold()

                // Explanation of the 5-letter word rule
                Text("The word will always be 5 letters long. As such, you can only type in words that are at least and at most 5 letters long.")
                    .padding(.bottom, 10)

                // Instruction to select a mode from the main menu
                Text("Select a mode from the main menu to view detailed instructions and start playing.")
                    .padding(.bottom, 10)
                
                // Instructions for user feedback
                Text("When you guess a word, it will be displayed back to the user in a list that shows what squares are wrong and which ones are right. Green squares mean you have the correct letter in the correct position. Yellow squares mean you have the correct letter in the wrong position. Grey squares mean you have the incorrect letter.")
                    .padding(.bottom, 10)

                // Section for Classic Mode instructions
                Text("Classic Mode")
                    .font(.title2)
                    .padding(.bottom, 5)
                    .bold()

                // Detailed instructions for Classic Mode
                Text("In Classic Mode, you have unlimited time to guess the word. Try to guess the word with the fewest attempts possible. You will receive feedback on each guess, indicating which letters are correct and in the correct position.")
                    .padding(.bottom, 10)

                // Section for Timed Mode instructions
                Text("Timed Mode")
                    .font(.title2)
                    .padding(.bottom, 5)
                    .bold()

                // Detailed instructions for Timed Mode
                Text("In Timed Mode, you have 60 seconds to guess the word. Try to guess the word before time runs out! You will receive feedback on each guess, indicating which letters are correct and in the correct position.")
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 50)
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
