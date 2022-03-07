//
//  ContentView.swift
//  Shared
//
//  Created by Arseniy Matus on 05.03.2022.
//
//

import SwiftUI

struct ContentView: View {
    @State var compChoice = ""
    @State var ifShouldWin = false
    @State var score = 0
    @State var isAlertedWin = false
    @State var alertedText = ""

    let gameVariants = ["🪨", "📄", "\("✂️")"]
    let beatingVariants = ["📄", "\("✂️")", "🪨"]

    func isBeated(_ first: String, with second: String) -> Bool {
        var firstInd = gameVariants.firstIndex(of: first)
        var secInd = beatingVariants.firstIndex(of: second)
        return firstInd == secInd
    }

    func playAgain() {
        alertedText = ""
    }

    func getAlertedtext(_ str: String) -> String {
        str + "\nComputed choice: \(compChoice) \nYou should have " + (ifShouldWin ? "won" : "lost")
    }

    func variantChosen(_ variant: String) {
        compChoice = gameVariants.randomElement() ?? ""
        ifShouldWin = Bool.random()
        if (isBeated(compChoice, with: variant) && ifShouldWin) {
            isAlertedWin = true
            score += 1
            alertedText = getAlertedtext("You won!")// + compChoice + String(ifShouldWin)
            return
        }
        if (!isBeated(compChoice, with: variant) && !ifShouldWin) {
            isAlertedWin = true
            score += 1
            alertedText = getAlertedtext("You lost but you won!")// + compChoice + String(ifShouldWin)
            return
        }
        if (isBeated(compChoice, with: variant) && !ifShouldWin) {
            isAlertedWin = true
            alertedText = getAlertedtext("You won but have to lose!")// + compChoice + String(ifShouldWin)
            return
        }
        if (!isBeated(compChoice, with: variant) && ifShouldWin) {
            isAlertedWin = true
            alertedText = getAlertedtext("You lost but have to win!")// + compChoice + String(ifShouldWin)
            return
        }

    }


    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Let's play Rock, Paper, Scissors!")
                        .fontWeight(.bold)
                        .padding(.vertical)
                Text("Shoot!")
                        .fontWeight(.semibold)
                        .padding(.bottom)
                HStack {
                    ForEach(gameVariants, id: \.self) { element in
                        Button {
                            variantChosen(element)
                        } label: {
                            Text(element)
                                    .font(.largeTitle)
                        }
                    }
                }
                Spacer()
                Spacer()

                HStack {
                    Text("Score:")
                    Text("\(score)")
                }
            }
        }
                .alert("Game over!", isPresented: $isAlertedWin) {
                    Button("Again", action: playAgain)
                } message: {
                    Text(alertedText)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
