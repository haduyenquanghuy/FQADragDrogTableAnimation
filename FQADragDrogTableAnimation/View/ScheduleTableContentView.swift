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
    
    @EnvironmentObject private var scheduleVM: ScheduleTaskConfigViewModel
    @StateObject private var labelVM = ScheduleLabelViewModel()
    @State private var translation = CGSize.zero
    
    var body: some View {
        
        VStack(spacing: -2) {
            ListUserRowView()
                .padding(.leading, AppConstant.hourLabelColumnWidth)
                .background(Color.white)
                .offset(y: max(0,-offset.y))
                .zIndex(1)
            
            HStack(spacing: 0) {
                HourLabelColumnView()
                    .frame(width: AppConstant.hourLabelColumnWidth)
                    .padding(.top, 12)
                    .background(Color.white)
                    .offset(x: max(0, -offset.x))
                    .zIndex(1)
                
                LazyVStack(spacing: 0, content: {
                    ForEach(0...AppConstant.hourPerDay, id: \.self) {
                        ScheduleRow(index: $0)
                    }
                })
                .overlay(alignment: .topLeading, content: {
                    Line()
                        .stroke(style: StrokeStyle(dash: [8]))
                        .stroke(Color.red, lineWidth: 1)
                        .frame(height: 1)
                        .padding(.top, 16)
                        .offset(y: labelVM.heightOffset)
                })
                .overlay(alignment: .topLeading) {
                    ForEach($scheduleVM.config) { conf in
                        let pos = scheduleVM.pos(at: conf.wrappedValue)
                        let task = scheduleVM.task(at: conf.wrappedValue)
                        
                        TaskView(blockScrollWhenDragTask: $blockScrollWhenDragTask,
                                 config: conf,
                                 isEdit: $isEdit, task: task)
                        .offset(x: CGFloat(pos?.column ?? 0) * AppConstant.rowWidth, y: CGFloat(pos?.index ?? 0) * AppConstant.rowHeight)
                        // push task to the most when it is selected
                        .zIndex(conf.isEdit.wrappedValue ? 1 : -1)
                    }
                }
            }
        }
        .environmentObject(scheduleVM)
        .environmentObject(labelVM)
    }
}
