//
//  MissionView.swift
//  moonshot
//
//  Created by lymos on 2022/7/17.
//

import SwiftUI

struct MissionView: View {
    struct crewMember{
        let role: String
        let astronaut: Astronaut
    }
    let astronauts: [crewMember]
    let mission: Mission
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.description)
                        .padding()
                    Spacer(minLength: 25)
                    
                    ForEach(self.astronauts, id: \.role){crewMember in
                        NavigationLink(destination: astronautView(astronaut: crewMember.astronaut)){
                            HStack{
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 65)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading){
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        // .ButtonStyle(PlainButtonStyle())
                    }
                }
            }
        }.navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        // 版本1
        /*
        var matchs = [crewMember]()
        for member in mission.crew{
            if let match = astronauts.first(where: {$0.id == member.name}){
                matchs.append(crewMember(role: member.role, astronaut: match))
            }else{
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matchs
         */
        
        // 版本2
        self.astronauts = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return crewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("missing \(member.name)")
            }
        }
    }
}



struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronaut.json")
    static var previews: some View {
        MissionView(mission: missions.randomElement()!, astronauts: astronauts)
    }
}
