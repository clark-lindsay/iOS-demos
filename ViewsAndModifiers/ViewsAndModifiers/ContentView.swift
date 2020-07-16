//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Clark Lindsay on 6/22/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct MessageText: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .font(.largeTitle)
        .clipShape(Capsule())
    }
}

extension View {
    func messageTextStyle() -> some View {
        self.modifier(MessageText())
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func blueTitleStyle() -> some View {
        self.modifier(BlueTitle())
    }
}

struct ContentView: View {
    private var macOSCurrent = Text("Catalina")
    private var macOSNext = Text("Big Sur")
    var body: some View {
        VStack {
            macOSCurrent
                .blueTitleStyle()
            macOSNext
                .blueTitleStyle()
            Text("What's next?")
                .messageTextStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
