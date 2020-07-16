//
//  ContentView.swift
//  Word Scramble
//
//  Created by Clark Lindsay on 6/29/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = "pentagon"
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Root word: \(rootWord)")
                    .font(.title)
                Text("Score: \(score)")
                TextField("Enter your word", text: $newWord, onCommit: addNewWordFromTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords.reversed(), id: \.self) { word in
                    Image(systemName: "\(word.count).circle")
                    Text(word)
                }
            }
            .navigationBarTitle("Word Scramble")
            .navigationBarItems(leading: Button(action: startGame) {
                Text("Restart")
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWordFromTextField() {
        let result = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard result.count > 0 else {
            return
        }
        guard isLongerThan(word: newWord) else {
            showWordError(title: "That's too short", message: "It's gotta be more than three letters.")
            return
        }
        guard isOriginal(word: newWord) else {
            showWordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: newWord) else {
            showWordError(title: "Not a possible word", message: "You can't spell \(newWord) from \(rootWord)!")
            return
        }
        guard isEnglis(word: newWord) else {
            showWordError(title: "That's not english", message: "As far as we can tell, that's not an english word!")
            return
        }
        
        usedWords.append(result)
        score += result.count
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word) && word != rootWord
    }
    
    func isPossible(word: String) -> Bool {
        var rootCopy = rootWord.lowercased()
        for letter in word {
            if let position = rootCopy.firstIndex(of: letter) {
                rootCopy.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isEnglis(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongerThan(_ minLength: Int = 4, word: String) -> Bool {
        return word.count >= minLength
    }
    
    func showWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingErrorAlert = true
    }
    
    func startGame() {
        if let startWordsURL  = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let words = startWords.components(separatedBy: "\n")
                
                rootWord = words.randomElement() ?? "pentagon "
                score = 0
                usedWords = [String]()
                return
            }
        }
        fatalError("Could not load 'start.txt' from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



