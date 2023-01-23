//
//  ContentView.swift
//  moonshot
//
//  Created by lymos on 2022/7/10.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        
        // Text("\(astronauts.count)")
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)){
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
