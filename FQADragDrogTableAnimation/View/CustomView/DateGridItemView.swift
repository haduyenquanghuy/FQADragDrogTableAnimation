//
//  DateGridItemView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct DateGridItemView: View {
    
    var column: Int
    var onSelectedCol: (Int) -> Void
    
    var body: some View {
        Color.white
            .frame(width: AppConstant.rowWidth)
            .frame(height: AppConstant.rowGridHeight)
            .border(width: 1, edges: [.trailing], color: Color(hex: "DEDEDE"))
            .onTapGesture {
                onSelectedCol(column)
            }
    }
}

struct DateGridRow: View {
    
    var row: Int
    var onSelected: (_ row: Int,_ column: Int) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< mockListUsers.count, id: \.self) {
                DateGridItemView(column: $0, onSelectedCol: { column in
                    onSelected(row, column)
                })
            }
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "DEDEDE"))
    }
}

struct DateRow: View {
    
    var index: Int
    @Binding var selectedPositions: [SchedulePositionModel]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< AppConstant.blockPerHour, id: \.self) {
                DateGridRow(row: $0, onSelected: { row, column in
                    
                    let newPosition = SchedulePositionModel(index: index, row: row, column: column)
                    
                    withAnimation(.linear(duration: 0.5)) {
                        selectedPositions.append(newPosition)
                    }
                    
                })
            }
        }
        .border(Color(hex: "B1B1B1"), width: 1)
    }
}

#Preview {
    DateRow(index: 4, selectedPositions: .constant([]))
}

