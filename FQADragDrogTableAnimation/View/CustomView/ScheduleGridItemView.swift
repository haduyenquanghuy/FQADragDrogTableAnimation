//
//  DateGridItemView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct ScheduleGridItemView: View {
    
    var column: Int
    var onSelectedCol: (Int) -> Void
    
    var body: some View {
        Color.white
            .frame(width: AppConstant.rowWidth)
            .frame(height: AppConstant.rowGridHeight)
            .border(width: 1, edges: [.trailing], color: Color(hex: "DEDEDE"))
            .onTapGesture {
               // add empty guesture to prevent longTapGesture block scrollView swipe
            }
            .onLongPressGesture(minimumDuration: 0.1) {
                onSelectedCol(column)
            }
    }
}

struct ScheduleGridRow: View {
    
    var row: Int
    var onSelected: (_ row: Int,_ column: Int) -> Void
    var numberOfRow: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< numberOfRow, id: \.self) {
                ScheduleGridItemView(column: $0, onSelectedCol: { column in
                    onSelected(row, column)
                })
            }
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "DEDEDE"))
    }
}

struct ScheduleRow: View {
    
    var index: Int
    var numberOfRow: Int
    @EnvironmentObject var vm: ScheduleTaskConfigViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< AppConstant.blockPerHour, id: \.self) {
                ScheduleGridRow(row: $0, onSelected: { row, column in
                    
                    let newPosition = SchedulePositionModel(index: index, row: row, column: column)
                    
                    withAnimation(.linear(duration: 0.36)) {
                        vm.create(new: newPosition)
                    }
                }, numberOfRow: numberOfRow)
            }
        }
        .border(Color(hex: "B1B1B1"), width: 1)
    }
}

#Preview {
    ScheduleRow(index: 4, numberOfRow: 4)
}

