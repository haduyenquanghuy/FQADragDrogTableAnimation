//
//  TaskView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 09/04/2024.
//

import SwiftUI

struct TaskView: View {
    
    @State private var scale: Double = 0
    @Binding var blockScrollWhenDragTask: Bool
    @Binding var config: TaskConfigModel
    @Binding var isEdit: Bool
    
    var onEditTask: (TaskConfigModel) -> ()
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                // add this animation block to make drag animation smooth
                withAnimation(.linear(duration: 0.05)) {
                    config.translation = value.translation
                }
            }
            .onEnded { value in
                blockScrollWhenDragTask = false
                
                config.lastTranslation.width += value.translation.width
                config.lastTranslation.height += value.translation.height
                config.translation = .zero
                
                withAnimation(.smooth(duration: 0.25)) {
                    let x = round((config.lastTranslation.width) / AppConstant.rowWidth)
                    let y = round((config.lastTranslation.height) / AppConstant.rowHeight)
                    config.lastTranslation = CGSize(width: x * AppConstant.rowWidth, height: y * AppConstant.rowHeight)
                }
            }
    }
    
    var body: some View {
        
        if config.isEdit {
            Color.blue
                .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.25), radius: 4, x: -config.shadowHeight, y: config.shadowHeight)
                .offset(x: config.shadowHeight / 4 , y: -config.shadowHeight / 4)
                .onAppear {
                    config.oldTranslation = config.lastTranslation
                    withAnimation(.smooth(duration: 0.25)) {
                        config.shadowHeight = 8
                    }
                }
                .offset(
                    x: config.lastTranslation.width + config.translation.width,
                    y: config.lastTranslation.height + config.translation.height
                )
                .gesture(dragGesture)
                .onLongPressGesture(minimumDuration: 0.0) {
                    // add this LongPressGesture to detect first enter to dragGesture to disable scrollView swipe
                    blockScrollWhenDragTask = true
                }
        } else {
            Color.blue
                .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
                .cornerRadius(8)
                .scaleEffect(scale)
                .offset(
                    x: config.lastTranslation.width + config.translation.width,
                    y: config.lastTranslation.height + config.translation.height
                )
                .onAppear {
                    config.shadowHeight = 0
                    withAnimation(.snappy(duration: 0.36, extraBounce: 0.36)) {
                        scale = 1
                    }
                }
                .onTapGesture {
                    config.isEdit = true
                    onEditTask(config)
                    withAnimation(.linear(duration: 0.25)) {
                        isEdit = true
                    }
                }
        }
    }
}
