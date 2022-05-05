//
//  ContentView.swift
//  FlashZilla
//
//  Created by Arseniy Matus on 05.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State private var cards = [Card]()
    @State private var isShowingEditView = false
    @State private var isActive = true
    @State private var timeRemainig = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack {
                Text("Time: \(timeRemainig)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(.black.opacity(0.6))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { i in
                        CardView(card: cards[i]) {
                            removeCard(at: i)
                        }
                        .stacked(at: i, in: cards.count)
                        .allowsHitTesting(i == cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemainig > 0)
                
                if cards.isEmpty {
                    Button("Reset game", action: resetGame)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.black.opacity(0.6))
                        .clipShape(Capsule())
                }
            }
            HStack {
                Spacer()
                VStack {
                    Button {
                        isShowingEditView = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(.black.opacity(0.6))
                            .clipShape(Circle())
                            .padding()
                    }
                    
                    Button(action: resetGame) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(.black.opacity(0.6))
                            .clipShape(Circle())
                            .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear(perform: resetGame)
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemainig > 0 && !cards.isEmpty {
                timeRemainig -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $isShowingEditView, onDismiss: resetGame ,content: EditView.init)

    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func resetGame() {
        timeRemainig = 100
        isActive = true
        loadData()
//        cards.shuffle()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
