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
    
    @EnvironmentObject private var vm: ScheduleTaskConfigViewModel
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
                    ForEach(0...AppConstant.hourPerDay, id: \.self) {
                        ScheduleRow(index: $0)
                    }
                })
                .overlay(alignment: .topLeading) {
                    ForEach($vm.config) { conf in
                        let pos = vm.pos(at: conf.wrappedValue)
                        
                        TaskView(blockScrollWhenDragTask: $blockScrollWhenDragTask,
                                 config: conf,
                                 isEdit: $isEdit)
                        .offset(x: CGFloat(pos?.column ?? 0) * AppConstant.rowWidth, y: CGFloat(pos?.index ?? 0) * AppConstant.rowHeight)
                        // push task to the most when it selected
                        .zIndex(conf.id == vm.currentConfigTask?.id ? 1 : -1)
                    }
                }
            }
        }
        .environmentObject(vm)
    }
}
