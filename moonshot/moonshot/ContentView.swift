//
//  ContentView.swift
//  moonshot
//
//  Created by lymos on 2022/7/10.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        
        // Text("\(astronauts.count)")
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: Text("detail view")){
                    Image(mission.image)
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
