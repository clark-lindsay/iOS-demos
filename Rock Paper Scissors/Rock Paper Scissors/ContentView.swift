//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Clark Lindsay on 6/25/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

let possibleMoves: [Moves] = [.rock, .paper, .scissors]
enum Moves: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
    
    func beats(_ other: Moves) -> Bool {
        if (self == .rock && other == .scissors) {
            return true
        } else if (self == .paper && other == .rock) {
            return true
        } else if (self == .scissors && other == .paper) {
            return true
        }
        return false
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var moveAgainstPlayer = possibleMoves[Int.random(in: 0...2)]
    @State private var intentToWin = Bool.random()
    @State private var showingGameEndAlert = false
    
    var body: some View {
        VStack {
            Text("Your score is: \(score)")
                .font(.largeTitle)
            Spacer()
            Text("You are trying to \(intentToWin ? "win" : "lose") against:")
                .font(.title)
            Text("\(moveAgainstPlayer.rawValue)")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            VStack {
                Button(action: {
                    self.play(move: .rock)
                }) {
                    Move(text: "\(Moves.rock.rawValue)")
                }
                    .padding()
                Button(action: {
                    self.play(move: .scissors)
                }) {
                    Move(text: "\(Moves.scissors.rawValue)")
                }
                    .padding()
                Button(action: {
                    self.play(move: .paper)
                }) {
                    Move(text: "\(Moves.paper.rawValue)")
                }
                    .padding()
            }
            Spacer()
        }
            .alert(isPresented: $showingGameEndAlert) {
                Alert(title: Text("You win!"), message: Text("Congratulations! Ready to play again?"), primaryButton: .default(Text("Let's do it!")) {
                        self.startNewGame()
                    }, secondaryButton: .default(Text("Nah, I wanna keep going!")))
        }
    }
    
    func play(move: Moves) {
        if (intentToWin && move.beats(moveAgainstPlayer)) {
            score += 1
        } else if (move == moveAgainstPlayer) {
            startNewRound()
        }
        else if (!intentToWin && !move.beats(moveAgainstPlayer)) {
            score += 1
        } else {
            score -= 1
        }
        
        if (score == 10) {
            showingGameEndAlert = true
        } else {
            startNewRound()
        }
    }
    
    func startNewRound() {
        intentToWin = Bool.random()
        moveAgainstPlayer = possibleMoves[Int.random(in: 0...2)]
    }
    
    func startNewGame() {
        intentToWin = Bool.random()
        moveAgainstPlayer = possibleMoves[Int.random(in: 0...2)]
        score = 0
    }
}

struct Move: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
