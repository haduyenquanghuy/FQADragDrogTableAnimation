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
    var isOfficeHour: Bool
    
    var body: some View {
        Color(hex: isOfficeHour ? "FFFFFF" : "B1B1B1")
            .frame(width: AppConstant.rowWidth)
            .frame(height: AppConstant.rowGridHeight)
            .border(width: 1, edges: [.trailing], color: Color(hex: isOfficeHour ? "DEDEDE" : "FFFFFF"))
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
    var isOfficeHour: Bool
    var isLast: Bool
    
    var body: some View {
        
        let borderColor = isOfficeHour ? "B1B1B1" : "FEFEFE"
        
        HStack(spacing: 0) {
            ForEach(0 ..< numberOfRow, id: \.self) {
                ScheduleGridItemView(column: $0, onSelectedCol: { column in
                    onSelected(row, column)
                }, isOfficeHour: isOfficeHour)
            }
        }
        .border(width: 1, edges: [.leading, .trailing], color:  Color(hex: borderColor))
        .border(width: isLast ? 2 : 1, edges: [.bottom, .trailing], color: Color(hex:borderColor))
    }

}

struct ScheduleRow: View {
    
    var index: Int
    var numberOfRow: Int
    @EnvironmentObject var vm: ScheduleTaskConfigViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< AppConstant.blockPerHour, id: \.self) { currentRow in
                ScheduleGridRow(row: currentRow, onSelected: { row, column in
                    
                    let newPosition = SchedulePositionModel(index: index, row: row, column: column)
                    
                    withAnimation(.linear(duration: 0.36)) {
                        vm.create(new: newPosition)
                    }
                }, numberOfRow: numberOfRow, isOfficeHour: vm.isOfficeHour(at: index, and: currentRow), isLast: currentRow == AppConstant.blockPerHour - 1)
            }
        }
    }
}

#Preview {
    ScheduleRow(index: 4, numberOfRow: 4)
}

