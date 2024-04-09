//
//  TaskView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 09/04/2024.
//

import SwiftUI

struct TaskView: View {
    
    @State var scale: Double = 0
    
    var body: some View {
        Color.red
            .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
            .cornerRadius(8)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.bouncy(duration: 0.36, extraBounce: 0.32)) {
                    scale = 1
                }
            }
    }
}

#Preview {
    TaskView()
}
