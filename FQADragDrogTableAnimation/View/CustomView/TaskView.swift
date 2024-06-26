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
    @EnvironmentObject private var vm: ScheduleTaskConfigViewModel
    
    var task: TaskModel?
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                // add this animation block to make drag animation smooth
                config.translation = value.translation
            }
            .onEnded { value in
                blockScrollWhenDragTask = false
                
                config.lastTranslation.width += value.translation.width
                config.lastTranslation.height += value.translation.height
                config.translation = .zero
                
                withAnimation(.smooth(duration: 0.25)) {
                    config.lastTranslation = vm.roundPosition(size: config.lastTranslation)
                }
            }
    }
    
    var body: some View {
        
        if config.isEdit {
            TaskContentView(task: task)
                .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
                .background(Color(uiColor: config.color))
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.25), radius: 4, x: -config.shadowHeight, y: config.shadowHeight)
                .offset(x: config.shadowHeight / 4 , y: -config.shadowHeight / 4)
                .onAppear {
                    config.oldTranslation = config.lastTranslation
                    withAnimation(.smooth(duration: 0.25)) {
                        config.shadowHeight = 12
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
            TaskContentView(task: task)
                .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
                .background(Color(uiColor: config.color))
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
                    if vm.currentConfigTask == nil {   
                        config.isEdit = true
                        vm.setCurrent(config: config)
                        withAnimation(.linear(duration: 0.25)) {
                            isEdit = true
                        }
                    }
                }
        }
    }
}
