//
//  ContentView.swift
//  MoonShot
//
//  Created by Arseniy Matus on 27.03.2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let content = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: content) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text("Apollo \(mission.id)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("\(mission.formattedLaunchDate)")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .background(.darkBackground)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
