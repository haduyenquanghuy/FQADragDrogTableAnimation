//
//  ScheduleTableContentView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct ScheduleTableContentView: View {
    
    @Binding var offset: CGPoint
    @Binding var isEdit: Bool
    @Binding var blockScrollWhenDragTask: Bool
    @Binding var config: TaskConfigModel
//    @Binding var selectedPostions: [SchedulePositionModel]
    
    @EnvironmentObject var vm: ScheduleTaskConfigViewModel
    
    @State private var translation = CGSize.zero
    
    var body: some View {
        
        VStack(spacing: -2) {
            ListUserRowView()
                .padding(.leading, 36)
                .background(Color.white)
                .offset(y: max(0,-offset.y))
                .zIndex(1)
            
            HStack(spacing: 0) {
                HourLabelColumnView()
                    .frame(width: 36)
                    .padding(.top, 12)
                    .background(Color.white)
                    .offset(x: max(0, -offset.x))
                    .zIndex(1)
                
                LazyVStack(spacing: 0, content: {
                    ForEach(0...23, id: \.self) {
                        ScheduleRow(index: $0)
                    }
                })
                .overlay(alignment: .topLeading) {
                    ForEach(vm.positions) { pos in
                        TaskView(blockScrollWhenDragTask: $blockScrollWhenDragTask,
                                 config: $config,
                                 translation: $translation,
                                 isEdit: $isEdit)
                            .offset(x: CGFloat(pos.column) * AppConstant.rowWidth, y: CGFloat(pos.index) * AppConstant.rowHeight)
                    }
                }
            }
        }
        .environmentObject(vm)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                // add this animation block to make drag animation smooth
                withAnimation(.linear(duration: 0.05)) {
                    translation = value.translation
                }
            }
            .onEnded { value in
                blockScrollWhenDragTask = false
                
                config.lastTranslation.width += value.translation.width
                config.lastTranslation.height += value.translation.height
                translation = .zero
                
                withAnimation(.smooth(duration: 0.25)) {
                    let x = round((config.lastTranslation.width) / AppConstant.rowWidth)
                    let y = round((config.lastTranslation.height) / AppConstant.rowHeight)
                    config.lastTranslation = CGSize(width: x * AppConstant.rowWidth, height: y * AppConstant.rowHeight)
                }
            }
    }
}
