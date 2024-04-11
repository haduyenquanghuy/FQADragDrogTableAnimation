//
//  CurrentTimeLabel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 11/04/2024.
//

import SwiftUI

struct CurrentTimeLabel: View {
    
    @Binding var currentTime: String
    
    var body: some View {
        Text(currentTime)
            .font(fontProvider.latoFont(size: 12, fontWeight: .bold))
            .foregroundStyle(.red)
            .fixedSize()
            .frame(width: AppConstant.hourLabelColumnWidth, height: 20)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 1)
            }
    }
}

#Preview {
    CurrentTimeLabel(currentTime: .constant("abc"))
}
