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
    @State private var shadowHeight: Double = 0
    
    @State private var oldTranslation = CGSize.zero
    @State private var lastTranslation = CGSize.zero
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            ScrollView([.horizontal], showsIndicators: false) {
                ScheduleTableContentView(offset: $offset, 
                                         isEdit: $isEdit,
                                         blockScrollWhenDragTask: $blockScrollWhenDragTask,
                                         shadowHeight: $shadowHeight,
                                         oldTranslation: $oldTranslation,
                                         lastTranslation: $lastTranslation)
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
                            lastTranslation = oldTranslation
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            withAnimation(.smooth(duration: 0.2)) {
                                shadowHeight = 0
                            }
                        })
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                            isEdit = false
                        })
                    }
                    
                    
                    CommonButton(title: "Lưu", backgroundColor: .black, foregroundColor: .white, strokeColor: .black) {
                        withAnimation(.smooth(duration: 0.2)) {
                            shadowHeight = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                            isEdit = false
                        })
                    }
                    
                    Spacer()
                }
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
