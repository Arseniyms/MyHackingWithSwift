//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Arseniy Matus on 17.03.2022.
//

import SwiftUI

func calculateMultNum(i: Int, j: Int, n: Int) -> Int {
    (i - 1) * (n - 1) + j
}

struct ContentView: View {
    let n = 5
    let firstNum = 2
    let animalPicture = "chicken"
    @State private var currValue = 0
    @State private var multNum = 0
    @State private var pressedNumbers = [Int]()

    private let amountOfQuestionArr = [5, 10, 20]
    @State private var amountOfQuestions = 5
    @State private var animalDegrees = -45.0

    @State private var score = 0
    @State private var count = 0

    @State private var writtenAnswer = ""
    @State private var questions = [question]()
    @State private var isPlay = false

    @State private var showError = false
    @State private var errorText = ""
    @State private var errorMessage = ""

    func getImageForNum(num: Int) -> String {
        pressedNumbers.contains(num) ? "\(num).square.fill" : "\(num).square"
    }

    private let BackGroundColor = Color(red: 169 / 255, green: 238 / 255, blue: 230 / 255)
    private let textColor = Color(red: 98 / 255, green: 87 / 255, blue: 114 / 255)
    private let buttonNumberColor = Color(red: 243 / 255, green: 129 / 255, blue: 129 / 255)

    struct question: Identifiable {
        var id: Int
        var a: Int
        var b: Int

        var question: String {
            "\(a) x \(b)"
        }

        var answer: Int {
            a * b
        }
    }

    func generateQuestions() {
        questions.removeAll()
        count = 0
        score = 0

        for i in 0..<amountOfQuestions {
            let b = Int.random(in: 1...(n - 1) * (n - 1))
            if let a = pressedNumbers.randomElement() {
                let temp = question(id: i, a: a, b: b)
                questions.append(temp)
                isPlay = true
            }
            else {
                showError = true
                errorText = "No numbers"
                errorMessage = "You have to choose numbers to play!"
            }
        }
    }

    func ifAnswerRight(ans: String) {
        if Int(ans) == questions[count].answer {
            count += 1
            score += 1
        }
        else {
            count += 1
        }

        writtenAnswer = ""
        
        if count >= amountOfQuestions {
            errorText = "Game over"
            errorMessage = "Your score is \(score) out of \(amountOfQuestions)"
            showError = true
            isPlay = false
            count = 0
            score = 0
        }
    }

    var body: some View {
        ZStack {
            BackGroundColor
                .opacity(0.4)
                .ignoresSafeArea()

            VStack {
                Text("Choose multiplication numbers")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .padding([.top, .bottom, .trailing])

                HStack(alignment: .center) {
                    Button {
                        generateQuestions()
                    } label: {
                        Image(animalPicture)
                            .rotationEffect(.degrees(animalDegrees))
                            .animation(.easeInOut(duration: 1)
                                .repeatForever(),
                                value: animalDegrees)
                            .padding()
                            .onAppear {
                                animalDegrees = 45.0
                            }
                    }

                    getNumMatrix()
                        .font(.largeTitle)
                }

                VStack(alignment: .leading) {
                    Text("How many questions?")
                        .font(.title2)
                        .foregroundColor(textColor)

                    Picker("How many questions?", selection: $amountOfQuestions) {
                        ForEach(amountOfQuestionArr, id: \.self) { Text($0.formatted()) }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    HStack {
                        Text("To start the game press the \(animalPicture)")
                            .fontWeight(.regular)

                        Image(systemName: "play")
                    }
                    .font(.headline)
                    .foregroundColor(textColor)
                }
                .padding(.horizontal)

                VStack {
                    if isPlay {
                        VStack(alignment: .center) {
                            Text("Question № \(questions[count].id + 1)")
                            TextField("What is \(questions[count].question)", text: $writtenAnswer)
                                .keyboardType(.decimalPad)
                                .fixedSize()
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                            Button() {
                                if !writtenAnswer.isEmpty {
                                    ifAnswerRight(ans: writtenAnswer)
                                }
                            } label:{
                                Image(systemName: "arrowshape.turn.up.right")
                            }
                            
                        }
                        .foregroundColor(textColor)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 300)
                        .background(BackGroundColor)
                        .cornerRadius(20)
                        
                    }
                }
                .opacity(isPlay ? 1 : 0)

                Spacer()
            }
        }
        .alert(errorText, isPresented: $showError) {
            Button("Got it", role: .cancel) {
            }
        } message: {
            Text(errorMessage)
        }
    }

    @ViewBuilder func getNumMatrix() -> some View {
        VStack {
            ForEach(1..<n, id: \.self) { i in
                HStack {
                    ForEach(1..<n, id: \.self) { j in
                        Button {
                            withAnimation {
                                let pressedNum = calculateMultNum(i: i, j: j, n: n)
                                if let index = pressedNumbers.firstIndex(of: pressedNum) {
                                    pressedNumbers.remove(at: index)
                                }
                                else {
                                    pressedNumbers.append(pressedNum)
                                }
                            }
                        } label: {
                            Image(systemName: getImageForNum(num: calculateMultNum(i: i, j: j, n: n)))
                                .foregroundColor(buttonNumberColor)
                        }
                        .scaleEffect(pressedNumbers.contains(calculateMultNum(i: i, j: j, n: n)) ? 0.85 : 1)
                    }
                }
                .padding(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
