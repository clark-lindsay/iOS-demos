//
//  ContentView.swift
//  Animations-Practice
//
//  Created by Clark Lindsay on 7/1/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var showingRedSquare = false
    @State private var enabled = false
    @State private var cardDragAmount = CGSize.zero
    @State private var letterDragAmount = CGSize.zero
    @State private var letterColor = Color.blue
    
    let letters = Array("Hello, SwiftUI!")
    
    var body: some View {
        VStack {
            Button("Tap me!") {
                // self.buttonSize += 1
            }
            .padding(50)
            .background(Color(.purple))
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.purple)
                    .opacity(Double(2 - animationAmount))
                    .scaleEffect(animationAmount)
                    .animation(
                        Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                    )
            )
            .onAppear {
                self.animationAmount = 2
            }
            Spacer()
            HStack(spacing: 0) {
                ForEach(0 ..< letters.count) { num in
                    Text(String(self.letters[num]))
                    .padding(5)
                        .background(self.letterColor)
                        .font(.title)
                        .offset(self.letterDragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged {
                        self.letterDragAmount = $0.translation
                }
                .onEnded { _ in
                    self.letterDragAmount = CGSize.zero
                    self.letterColor = (self.letterColor == .blue) ? .red : .blue
                }
            )
            Spacer()
            Color.blue
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(cardDragAmount)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.cardDragAmount = $0.translation
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.cardDragAmount = CGSize.zero
                        }
                    }
            )
            Spacer()
            Button("\(showingRedSquare ? "Hide Extra Button" : "Show Extra Button")") {
                withAnimation {
                    self.showingRedSquare.toggle()
                }
            }
            if (showingRedSquare) {
                Button("Tap me too!") {
                    self.enabled.toggle()
                }
                .frame(width: 200, height: 200)
                .background(enabled ? Color.blue : Color.red)
                .foregroundColor(.white)
                .animation(.default)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                .animation(.easeOut(duration: 2))
                .transition(.pivot)
            }
        }
    }
}

struct CornerRotate: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotate(amount: -90, anchor: .topLeading),
            identity: CornerRotate(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
