//
//  ContentView.swift
//  edutainment
//
//  Created by Carson Gross on 6/3/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selector = 2
    @State private var questions: Int = 5
    @State private var difficulty = "Medium"
    @State private var questionNumber = 0
    @State private var inputAnswer = 0
    @FocusState private var answerIsFocused: Bool
    @State private var showGame = false
    @State private var score = 0
    @State private var showAlert = false
    
    
    @State private var questionsArray = [Question]()
    let questionAmount = [5,10,20]
    let difficulties = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("Multiplication Number:")
                        .font(.headline)
                    Stepper("\(selector)", value: $selector, in: 2...12)
                        .font(.headline)
                }
                VStack {
                    Picker("Number of quesitons:", selection: $questions) {
                        ForEach(questionAmount, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                }
                VStack {
                    Picker("Difficulty:", selection: $difficulty) {
                        ForEach(difficulties, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                }
                VStack {
                    Button("Start Game") {
                        startGame()
                    }
                }
                VStack {
                    if showGame {
                        Text("\(questionsArray[questionNumber].question)")
                        TextField("Answer", value: $inputAnswer, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($answerIsFocused)
                    } else {
                        Text("Press 'Start Game' when your settings are ready!")
                    }
                }
                Button("Submit") {
                    submitAnswer()
                }
                .disabled(!showGame)
                Text("Score: \(score)")
            }.navigationTitle("Settings")
        }.alert("You Finished!", isPresented: $showAlert) {
            Button("Continue") { }
        }
    }
    
    func startGame() {
        score = 0
        switch difficulty {
        case "Easy":
            for _ in 0...questions {
                questionsArray.append(Question(int1: Int.random(in: 1...selector), int2: Int.random(in: 1...selector)))
            }
        case "Medium":
            for _ in 0...questions {
                questionsArray.append(Question(int1: Int.random(in: 1...selector), int2: Int.random(in: 2...selector)))
            }
        case "Hard":
            for _ in 0...questions {
                questionsArray.append(Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector)))
            }
        default:
            for _ in 0...questions {
                questionsArray.append(Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector)))
            }
        }
        showGame = true
    }
    
    func endGame() {
        showAlert = true
        showGame = false
        questionsArray.removeAll()
        questionNumber = 0
    }
    
    func checkAnswer() {
        if questionsArray[questionNumber].answer == inputAnswer {
            score += 1
        }
    }
    
    func submitAnswer() {
        if questionNumber < questions - 1 {
            checkAnswer()
            questionNumber += 1
        } else {
            checkAnswer()
            endGame()
        }
    }
}

struct gameView: View {
    var questionsArray = [Question]()
    
    var body: some View {
        VStack {
            List(questionsArray, id: \.self) {
                Text($0.question)
            }
        }
    }
}

struct Question: Hashable {
    var int1: Int
    var int2: Int
    var answer: Int
    var question: String
    
    init (int1: Int, int2: Int) {
        self.int1 = int1
        self.int2 = int2
        self.answer = int1 * int2
        self.question = "\(int1) x \(int2) = ?"
    }
    
    func askQuestion() -> String {
        question
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
