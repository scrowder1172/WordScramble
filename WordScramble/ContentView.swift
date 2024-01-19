//
//  ContentView.swift
//  WordScramble
//
//  Created by SCOTT CROWDER on 10/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords: [String] = [String]()
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    @State private var score: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(usedWords, id:\.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                            .accessibilityElement()
                            .accessibilityLabel(word)
                            .accessibilityHint("\(word.count) letters")
                            
                        }
                    }
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) { } message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Restart", action: startGame)
                }
                Text("Scoring System:\n3-4 letter word: 1 pt\n5-6 letter word: 3 pt\n7-8 letter word: 5 pt")
                Rectangle()
                    .frame(width: .infinity, height: 2)
                Text("Your Score: \(score)")
                    .font(.largeTitle)
            }
            
        }
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        guard isNotRootword(word: answer) else {
            wordError(title: "Word invalid", message: "Do not use root word")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isTooShort(word: answer) else {
            wordError(title: "Word too short", message: "Words should be at least 3 characters")
            return
        }
        
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            if answer.count < 5 {
                score += 1
            } else if answer.count < 7 {
                score += 3
            } else {
                score += 5
            }
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                score = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isNotRootword(word: String) -> Bool {
        return word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isTooShort(word: String) -> Bool {
        return word.count > 2
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        return misspellRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
