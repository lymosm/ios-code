//
//  astronautView.swift
//  moonshot
//
//  Created by lymos on 2022/7/17.
//

import SwiftUI

struct astronautView: View {
    let astronaut: Astronaut
    var body: some View {
        GeometryReader{geometry in
            ScrollView{
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
}

struct astronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        astronautView(astronaut: astronauts["armstrong"]!)
    }
}
