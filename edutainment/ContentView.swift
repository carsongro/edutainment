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
            }
        }
    }
    func startGame() {
        switch difficulty {
        case "Easy":
            for i in 0...questions {
                questionsArray[i] = Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector))
            }
        case "Medium":
            for i in 0...questions {
                questionsArray[i] = Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector))
            }
        case "Hard":
            for i in 0...questions {
                questionsArray[i] = Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector))
            }
        default:
            for i in 0...questions {
                questionsArray[i] = Question(int1: Int.random(in: 2...selector), int2: Int.random(in: 2...selector))
            }
        }
    }
}

struct Question {
    var int1: Int
    var int2: Int
    var answer: Int
    var question: String
    
    init (int1: Int, int2: Int) {
        self.int1 = int1
        self.int2 = int2
        self.answer = int1 * int2
        self.question = "\(int1) x \(int2) = "
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
