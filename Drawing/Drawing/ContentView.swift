//
//  ContentView.swift
//  Drawing
//
//  Created by Clark Lindsay on 8/17/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct Hexagon: InsettableShape {
    var insetAmount: CGFloat = 0
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var result = Path()
        let effectiveWidth = rect.width - insetAmount * 2
        let points = ["minX": rect.minX + insetAmount,
                      "midX": rect.midX - insetAmount,
                      "maxX": rect.maxX - insetAmount,
                      "minY": rect.minY + insetAmount,
                      "midY": rect.midY - insetAmount,
                      "maxY": rect.maxY - insetAmount]
        
        result.move(to: CGPoint(x: (effectiveWidth / 4) * 3, y: points["minY"]!))
        result.addLine(to: CGPoint(x: points["maxX"]!, y: points["midY"]!))
        result.addLine(to: CGPoint(x: (effectiveWidth / 4) * 3, y: points["maxY"]!))
        result.addLine(to: CGPoint(x: (effectiveWidth / 4), y: points["maxY"]!))
        result.addLine(to: CGPoint(x: points["minX"]!, y: points["midY"]!))
        result.addLine(to: CGPoint(x: (effectiveWidth / 4), y: points["minY"]!))
        result.addLine(to: CGPoint(x: (effectiveWidth / 4) * 3, y: points["minY"]!))
        
        return result
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var result = self
        result.insetAmount += amount
        return result
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let adjustedStart = startAngle - rotationAdjustment
        let adjustedEnd = endAngle - rotationAdjustment
        var result = Path()
        
        result.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: adjustedStart, endAngle: adjustedEnd, clockwise: clockwise)
        
        return result
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var result = self
        result.insetAmount += amount
        return result
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var result = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            result.addPath(rotatedPetal)
        }
        return result
    }

}

struct ContentView: View {
    @State private var insetAmount: CGFloat = 50
    @State private var circleRadiusMultiplier: CGFloat = 1
    
    var body: some View {
        VStack {
            Hexagon(insetAmount: insetAmount)
                .frame(width: 300, height: 250)
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation {
                    self.insetAmount = CGFloat.random(in: 10...90)
                    }
                }
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 100 * circleRadiusMultiplier)
                        .offset(x: -50, y: -50)
                        .blendMode(.screen)
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 100 * circleRadiusMultiplier)
                        .offset(x: 50, y: -50)
                        .blendMode(.screen)
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 100 * circleRadiusMultiplier)
                        .offset(x: 0, y: 50)
                        .blendMode(.screen)
                }
                    .frame(width: 300, height: 300)
                Slider(value: $circleRadiusMultiplier, in: 0...3)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            .edgesIgnoringSafeArea(.all)

        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
