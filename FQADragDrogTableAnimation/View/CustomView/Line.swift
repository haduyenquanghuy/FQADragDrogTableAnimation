//
//  Line.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 11/04/2024.
//

import SwiftUI

struct Line: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
    
}

#Preview {
    ZStack {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
    }
}
