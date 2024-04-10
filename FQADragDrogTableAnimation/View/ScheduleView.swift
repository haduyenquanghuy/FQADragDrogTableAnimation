//
//  ScheduleView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct ScheduleView: View {
    
    @State private var offset = CGPoint.zero
    @State private var isEdit = false
    
    @State private var blockScrollWhenDragTask = false
    @State private var config = TaskConfigModel()
    @State private var selectedPositions: [SchedulePositionModel] = []
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            ScrollView([.horizontal], showsIndicators: false) {
                ScheduleTableContentView(offset: $offset,
                                         isEdit: $isEdit,
                                         blockScrollWhenDragTask: $blockScrollWhenDragTask,
                                         config: $config,
                                         selectedPostions: $selectedPositions)
                    .background( GeometryReader { geo in
                        Color.clear
                            .preference(key: ViewOffsetKey.self, 
                                        value: geo.frame(in: .named("scroll")).origin)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        offset = value
                    }
            }
            .scrollDisabled(blockScrollWhenDragTask)
        }
        .scrollDisabled(blockScrollWhenDragTask)
        .overlay(alignment: .bottom, content: {
            if isEdit {
                
                HStack(spacing: 12) {
                    
                    Spacer()
                    
                    CommonButton(title: "Huỷ bỏ", backgroundColor: .white, foregroundColor: .black, strokeColor: .black) {
                        
                        withAnimation(.smooth(duration: 0.5)) {
                            config.lastTranslation = config.oldTranslation
                        }
                        
                        // wait for move task to last translation end (0.5s)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            withAnimation(.smooth(duration: 0.2)) {
                                config.shadowHeight = 0
                            }
                        })
                        
                        //wait for shadow animation by delay 0.7s = 0.5(move task to last translation) + 0.2 (shadow animation)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                            config.isEdit = false
                        })
                        
                        withAnimation(.linear(duration: 0.4)) {
                            isEdit = false
                        }
                    }
                    
                    
                    CommonButton(title: "Lưu", backgroundColor: .black, foregroundColor: .white, strokeColor: .black) {
                        withAnimation(.smooth(duration: 0.2)) {
                            config.shadowHeight = 0
                        }
                        
                        // wait for shadow animation end by 0.2s delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            config.isEdit = false
                        })
                        
                        withAnimation(.linear(duration: 0.3)) {
                            isEdit = false
                        }
                    }
                    
                    Spacer()
                }
                .transition(.asymmetric(insertion: .fly, removal: .scale.combined(with: .opacity)))
                
            } else {
                EmptyView()
            }
        })
        .coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.x += nextValue().x
        value.y += nextValue().y
    }
}

#Preview {
    ScheduleView()
}
