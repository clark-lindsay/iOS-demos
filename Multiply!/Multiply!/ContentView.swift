//
//  ContentView.swift
//  Multiply!
//
//  Created by Clark Lindsay on 7/6/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isInSetupMode = true
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var minimumMutiplicand = 1
    @State private var maximumMultiplicand = 7
    @State private var numberOfQuestions = 10
    @State private var questions: [(Int, Int)] = []

    var body: some View {
        Group {
            if isInSetupMode {
                VStack {
                    Text("Setting up...")
                    Stepper("Lower Range: \(minimumMutiplicand)", value: $minimumMutiplicand, in: 1 ... maximumMultiplicand)
                    Stepper("Upper Range: \(maximumMultiplicand)", value: $maximumMultiplicand, in: minimumMutiplicand ... 12)
                    Stepper("Number of questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 5 ... 25, step: 5)
                    Button("Let's go!") {
                        self.isInSetupMode.toggle()
                        for a in self.minimumMutiplicand ... self.maximumMultiplicand {
                            for b in self.minimumMutiplicand ... self.maximumMultiplicand {
                                self.questions.append((a, b))
                            }
                        }
                        self.questions.shuffle()
                        self.questions = self.questions.dropLast(self.questions.count - self.numberOfQuestions)
                    }
                }
            } else {
                MultiplicationQuiz(questions: self.questions)
            }
        }
    }
}

struct MultiplicationQuiz: View {
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var questions: [(Int, Int)] = []

    init(questions: [(Int, Int)]) {
        _questions = State(initialValue: questions)
    }

    var body: some View {
        Group {
            if currentQuestion == questions.count {
                Text("Nice job!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            } else {
                VStack {
                    Text("Question: \(questions[currentQuestion].0) x \(questions[currentQuestion].1)")
                    TextField("Answer", text: $answer, onCommit: {
                        let targetProduct = self.questions[self.currentQuestion].0 * self.questions[self.currentQuestion].1
                        if let answer = Int(self.answer) {
                            if answer == targetProduct {
                                self.currentQuestion += 1
                                self.answer = ""
                            }
                        }
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
