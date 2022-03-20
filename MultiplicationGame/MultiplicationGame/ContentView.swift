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
    let n = 4
    @State private var currValue = 0
    @State private var multNum = 0
    @State private var pressedNumbers = [Int]()

    private var amountOfQuestionArr = [5, 10, 20]
    @State private var amountOfQuestions = 5
    @State private var animalDegrees = -45.0

    func getImageForNum(num: Int) -> String {
        pressedNumbers.contains(num) ? "\(num).square.fill" : "\(num).square"
    }

    private let BackGroundColor = Color(red: 169 / 255, green: 238 / 255, blue: 230 / 255)
    private let textColor = Color(red: 98 / 255, green: 87 / 255, blue: 114 / 255)
    private let buttonNumberColor = Color(red: 243 / 255, green: 129 / 255, blue: 129 / 255)

    var body: some View {
        ZStack {
            BackGroundColor
                .opacity(0.4)
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text("Choose multiplication numbers")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .padding([.top, .leading, .trailing])

                HStack {
                    Spacer()
                    Image("chicken")
                        .rotationEffect(.degrees(animalDegrees))
                        .animation(.easeInOut(duration: 1)
                            .repeatForever(),
                            value: animalDegrees)
                        .padding([.top, .bottom, .trailing])
                        .onAppear {
                            animalDegrees = 45.0
                        }
                    getNumMatrix()
                        .font(.largeTitle)
                        .padding()
                }
                .padding()

                Group {
                    Text("How many questions?")
                        .font(.title2)
                        .padding(.horizontal)
                        .foregroundColor(textColor)
                    Picker("How many questions?", selection: $amountOfQuestions) {
                        ForEach(amountOfQuestionArr, id: \.self) { Text($0.formatted()) }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }

                Spacer()
            }
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
