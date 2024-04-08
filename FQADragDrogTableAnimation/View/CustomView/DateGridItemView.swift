//
//  DateGridItemView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct DateGridItemView: View {
    var body: some View {
        ZStack {
            
        }
        .frame(width: AppConstant.rowWidth)
        .frame(height: AppConstant.rowGridHeight)
        .border(width: 1, edges: [.trailing], color: Color(hex: "DEDEDE"))
    }
}

struct DateGridRow: View {
    var body: some View {
        HStack(spacing: 0) {
            DateGridItemView()
            DateGridItemView()
            DateGridItemView()
            DateGridItemView()
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "DEDEDE"))
    }
}

struct DateRow: View {
    var body: some View {
        VStack(spacing: 0) {
            DateGridRow()
            DateGridRow()
            DateGridRow()
            DateGridRow()
        }
        .border(Color(hex: "B1B1B1"), width: 1)
    }
}

#Preview {
    DateRow()
}
