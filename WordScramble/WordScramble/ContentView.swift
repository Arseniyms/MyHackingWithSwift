//
//  ContentView.swift
//  WordScramble
//
//  Created by Arseniy Matus on 08.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var guessedWords = [String]()
    @State private var chosenWord = ""
    @State private var newWord = ""
    @State private var score = 0

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Write your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(guessedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(chosenWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Your score is \(score)")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Start new game") {
                        startGame()
                    }
                }
            }
            .alert(errorTitle, isPresented: $showAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else { return }
        guard answer != chosenWord else {
            wordError(title: "It is your given word.", message: "Don't be so naive.")
            return
        }
        guard checkIfUnique(word: answer) else {
            wordError(title: "Word already used.", message: "You have to be more unique.")
            return
        }
        guard checkIfPossible(word: answer) else {
            wordError(title: "Impossible word.", message: "Try to make word out of the given letter.")
            return
        }
        guard checkIfValid(word: answer) else {
            wordError(title: "Unknown word", message: "Try to find real words.")
            return
        }

        withAnimation {
            guessedWords.insert(newWord, at: 0)
            newWord = ""
            score += 1
        }
    }

    func checkIfUnique(word: String) -> Bool {
        !guessedWords.contains(word)
    }

    func checkIfPossible(word: String) -> Bool {
        var tempWord = chosenWord

        for letter in word {
            if let i = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: i)
            }
            else {
                return false
            }
        }

        return true
    }

    func checkIfValid(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return NSNotFound == misspelledRange.location
    }

    func startGame() {
        if let startGameBundle = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startGameBundle) {
                let allWords = startWords.components(separatedBy: "\n")

                withAnimation {
                    chosenWord = allWords.randomElement() ?? "Error"
                    guessedWords.removeAll()
                }

                return
            }
        }

        fatalError("Couldn't load the game.")
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showAlert = true
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
