//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arseniy Matus on 23.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"] // .shuffled()
    @State private var correctAnswer = Int.random(in: 1...2)
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var isPresentingScore = false
    @State private var isWin = false
    private let scoreLimit = 3

    @State private var animationAmount = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var scales = [1.0, 1.0, 1.0]

    func flagChosen(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong!\n This is the flag of \(countries[number])"
        }

        withAnimation(.easeInOut(duration: 1)) {
            animationAmount[number] += 360
            scales[number] = 1.5
            for i in 0..<3 {
                if i != correctAnswer {
                    opacities[i] = 0.25
                    scales[i] = 0.5
                }
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
            isPresentingScore = true
            if score == scoreLimit {
                isWin = true
                isPresentingScore = false
            }
        }

        
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 1...2)
        if score >= scoreLimit {
            score = 0
        }

        for i in 0..<3 {
            opacities[i] = 1.0
            scales[i] = 1.0
        }
    }

    @ViewBuilder func FlagImage(_ i: Int) -> some View {
        Image(countries[i])
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:
                [Color(red: 20, green: 0.5, blue: 1.0),
                 Color(red: 2.00, green: 0.55, blue: 0.187)]),
            startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack {
                    VStack {
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .titled(with: "Choose the flag of")
                    }
                }
                .padding(30)

                ForEach(0..<3) { i in
                    Button {
                        flagChosen(i)
                    } label: {
                        FlagImage(i)
                    }
                    .rotation3DEffect(.degrees(correctAnswer == i ? animationAmount[i] : 0),
                                      axis: (x: 0, y: 1, z: 0))
                    .opacity(opacities[i])
                    .scaleEffect(correctAnswer != i ? scales[i] : scales[i])
                }

                Spacer()
                Spacer()
                VStack {
                    Text("Score \(score)")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
        }
        .shadow(radius: 20)
        .alert("Congratulations", isPresented: $isWin) {
            Button("Start new game", action: askQuestion)
        } message: {
            Text("Yoy have won!")
        }
        .alert(scoreTitle, isPresented: $isPresentingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
}

struct TitleMod: ViewModifier {
    var TextMod: String

    func body(content: Content) -> some View {
        VStack {
            Text(TextMod)
                .foregroundColor(.blue)
                .font(.title3)
                .fontWeight(.bold)
            content
        }
    }
}

extension View {
    func titled(with title: String) -> some View {
        modifier(TitleMod(TextMod: title))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
