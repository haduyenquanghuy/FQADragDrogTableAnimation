//
//  TaskContentView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 10/04/2024.
//

import SwiftUI

struct TaskContentView: View {
    
    var task: TaskModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(task?.startTime ?? "-") - \(task?.endTime ?? "-")")
                .font(fontProvider.latoFont(size: 14, fontWeight: .medium))
                .foregroundStyle(.white)
            
            Text(task?.content ?? "")
                .font(fontProvider.latoFont(size: 12, fontWeight: .regular))
                .foregroundStyle(.white)
            
            Spacer()
            
            HStack(spacing: 0) {
                Spacer()
                
                Image("ic_star")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(8)
    }
}

#Preview {
    TaskContentView(task: TaskModel(startTime: "5h00", endTime: "6h00", content: "Viết gì đó đi"))
}
