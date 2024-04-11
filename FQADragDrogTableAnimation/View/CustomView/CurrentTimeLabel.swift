//
//  CurrentTimeLabel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 11/04/2024.
//

import SwiftUI

struct CurrentTimeLabel: View {
    
    let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        return dateFormatter
    }()
    
    var body: some View {
        Text(dateFormatter.string(from: Date.now))
            .font(fontProvider.latoFont(size: 12, fontWeight: .bold))
            .foregroundStyle(.red)
            .fixedSize()
            .frame(width: AppConstant.hourLabelColumnWidth, height: 20)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 1)
            }
    }
}

#Preview {
    CurrentTimeLabel()
}
