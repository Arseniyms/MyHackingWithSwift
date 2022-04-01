//
//  ContentView.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 30.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habitsDict = Habits()
    
    @State private var isShowingAddHabitToDict = false
    @State private var isShowingAddPersonalHabit = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(habitsDict.habits.map{$0.key}) { habit in
                        NavigationLink {
                            DescirptionHabitView(habitsDict: habitsDict,habit: habit)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .fill(.black)
                                    .frame(width: 100, height: 100, alignment: .center)
                                
                                Text("\(habit.emoji)")
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("iHabit")
            .toolbar {
                HStack {
                    Button {
                        isShowingAddHabitToDict.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button {
                        isShowingAddPersonalHabit.toggle()
                    } label: {
                        Image(systemName: "plus.square.on.square")
                    }
                }
                
            }
            .sheet(isPresented: $isShowingAddHabitToDict) {
                AddHabitToListView(habitsDict: habitsDict)
            }
            .sheet(isPresented: $isShowingAddPersonalHabit) {
                AddPersonalHabitView(habitsDict: habitsDict)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
