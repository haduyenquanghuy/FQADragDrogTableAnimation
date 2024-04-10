//
//  HourLabelItemView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct HourLabelItemView: View {
    var hour: String
    
    var body: some View {
        
        Text("\(hour):00")
            .font(fontProvider.latoFont(size: 14, fontWeight: .bold))
            .bold()
            .fixedSize(horizontal: true, vertical: true)
            .frame(height: AppConstant.rowGridHeight * CGFloat(AppConstant.blockPerHour), alignment: .top)
            .frame(maxWidth: .infinity)
    }
}

struct HourLabelColumnView: View {
    
    var body: some View {
        VStack(spacing: 0, content: {
            ForEach(0...AppConstant.hourPerDay, id: \.self) { count in
                HourLabelItemView(hour: String(count))
            }
        })
    }
}

#Preview {
    HourLabelColumnView()
}
