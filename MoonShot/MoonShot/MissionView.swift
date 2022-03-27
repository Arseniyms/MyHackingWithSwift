//
//  MissionView.swift
//  MoonShot
//
//  Created by Arseniy Matus on 27.03.2022.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        var astronaut: Astronaut
    }

    let crew: [CrewMember]
    let mission: Mission

    @State private var isShowingCrewMember = false
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("Mission highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical, 2)

                        Text(mission.description)

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical, 2)

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { member in
                                Button{
                                    isShowingCrewMember.toggle()
                                } label: {
                                    HStack {
                                        Image(member.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                        VStack(alignment: .leading) {
                                            Text(member.astronaut.name)
                                                .foregroundColor(.white)
                                            
                                            Text(member.role)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                    }
                                }
                                .padding([.leading, .top])
                                .sheet(isPresented: $isShowingCrewMember) {
                                    (AstronautView(astronaut: member.astronaut))
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
