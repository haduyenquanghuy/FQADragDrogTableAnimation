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
    @Binding var isEditWithAnimation: Bool
    @Binding var blockScrollWhenDragTask: Bool
    @Binding var config: TaskConfigModel
    @Binding var selectedPostions: [SchedulePositionModel]
    
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
                        ScheduleRow(index: $0, selectedPositions: $selectedPostions)
                    }
                })
                .overlay(alignment: .topLeading) {
                    if isEdit {
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
                                x: config.lastTranslation.width + translation.width,
                                y: config.lastTranslation.height + translation.height
                            )
                            .gesture(
                                dragGesture
                            )
                            .onLongPressGesture(minimumDuration: 0.0, perform: {
                                // add this LongPressGesture to detect first enter to dragGesture to disable scrollView swipe
                                blockScrollWhenDragTask = true
                            })
                    } else {
                        Color.blue
                            .frame(width: AppConstant.rowWidth, height: AppConstant.rowHeight)
                            .cornerRadius(8)
                            .offset(
                                x: config.lastTranslation.width + translation.width,
                                y: config.lastTranslation.height + translation.height
                            )
                            .onAppear {
                                config.shadowHeight = 0
                            }
                            .onTapGesture {
                                isEdit = true
                                withAnimation(.linear(duration: 0.25)) {
                                    isEditWithAnimation = true
                                }
                            }
                    }
                }
                .overlay(alignment: .topLeading) {
                    ForEach(selectedPostions) { pos in
                        TaskView()
                            .offset(x: CGFloat(pos.column) * AppConstant.rowWidth, y: CGFloat(pos.index) * AppConstant.rowHeight)
                    }
                }
            }
        }
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
