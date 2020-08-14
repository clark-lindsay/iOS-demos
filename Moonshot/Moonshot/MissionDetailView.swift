//
//  MissionDetailView.swift
//  Moonshot
//
//  Created by Clark Lindsay on 8/14/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct MissionDetailView: View {
    struct CrewMember {
        let astronaut: Astronaut
        let role: String
    }
    
    let mission: Mission
    let astronauts: [Astronaut]
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == member.name
            }) {
                matches.append(CrewMember(astronaut: match, role: member.role))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.crew = matches
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.description)
                        .padding()
                    ForEach(self.crew, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautDetailView(astronaut: crewMember.astronaut)) {
                            CrewMemberView(crewMember: crewMember)
                            .padding(.horizontal)
                        }
                    .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    struct CrewMemberView: View {
        let crewMember: CrewMember
        let imageClipShape = RoundedRectangle(cornerRadius: 5)
        
        var body: some View {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 110)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape
                        .stroke(crewMember.role == "Commander" || crewMember.role == "Command Pilot" ? Color.yellow : Color.primary, lineWidth: 2))
                Spacer()
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .font(.headline)
                    Text(crewMember.role)
                        .font(.subheadline)
                }
                Spacer()
            }
        }
    }
}

struct MissionDetailView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astroanuts.json")
    
    static var previews: some View {
        MissionDetailView(mission: self.missions.first ?? Mission(id: 1, crew: [], launchDate: nil, description: "N/A"), astronauts: astronauts)
    }
}
