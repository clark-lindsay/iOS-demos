//
//  AstronautDetailView.swift
//  Moonshot
//
//  Created by Clark Lindsay on 8/14/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width * 0.9)
                    Text(self.astronaut.description)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautDetailView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetailView(astronaut: astronauts.first ?? Astronaut(id: "error", name: "error", description: "error"))
    }
}
