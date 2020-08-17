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
    
    func path(in rect: CGRect) -> Path {
        var result = Path()
        let effectiveWidth = rect.width - insetAmount
        let points = ["minX": rect.minX + insetAmount,
                      "midX": rect.midX,
                      "maxX": rect.maxX - insetAmount,
                      "minY": rect.minY + insetAmount,
                      "midY": rect.midY,
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

struct ContentView: View {
    var body: some View {
        ZStack {
            Hexagon()
                .strokeBorder(Color.green, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 275, height: 250)
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
                .strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .frame(width: 275, height: 250)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
