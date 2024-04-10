//
//  CommonButton.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct CommonButton: View {
    
    var title: String
    var backgroundColor: Color
    var foregroundColor: Color
    var strokeColor: Color
    var action: (() -> ())
    
    var body: some View {
        Button(action: action, label: {
            Text(title.uppercased())
                .foregroundStyle(foregroundColor)
                .font(fontProvider.latoFont(size: 18, fontWeight: .bold))
                .fixedSize()
                .frame(width: 136, height: 48)
        })
        .background(backgroundColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(strokeColor, lineWidth: 1.0)
        )
    }
}

#Preview {
    CommonButton(title: "Huỷ Bỏ", backgroundColor: .black, foregroundColor: .white, strokeColor: .black, action: {})
}
