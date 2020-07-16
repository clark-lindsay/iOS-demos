//
//  ContentView.swift
//  Freedom Habits (0.0.1)
//
//  Created by Clark Lindsay on 6/27/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
               HabitButton(action: {
                print("You exercised!")
               }, content:
                Text("Exercise"))
            }
            HStack {
                Button("Mindfulness") {
                    print("You meditated!")
                }
                    .habitButtonStyle()
                Button("Programming") {
                    print("You practiced talking to computers!")
                }
                    .habitButtonStyle()
            }
        }
    }
}

struct HabitButton<Content: View>: View {
    var action: () -> Void
    var content: Content
    var body: some View {
        Button(action: self.action) {
            content
                .habitButtonStyle()
        }
    }
}

struct HabitButtonContentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 170)
            .foregroundColor(.white)
            .background(Color(.blue))
            .font(.title)
            .clipShape(Circle())
            .buttonStyle(DefaultButtonStyle())
    }
}

extension View {
    func habitButtonStyle() -> some View {
        self.modifier(HabitButtonContentStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
