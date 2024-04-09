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
    @State private var isEditWithAnimation = false
    @State private var blockScrollWhenDragTask = false
    @State private var shadowHeight: Double = 0
    
    @State private var oldTranslation = CGSize.zero
    @State private var lastTranslation = CGSize.zero
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            ScrollView([.horizontal], showsIndicators: false) {
                ScheduleTableContentView(offset: $offset, 
                                         isEdit: $isEdit, 
                                         isEditWithAnimation: $isEditWithAnimation,
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
            if isEditWithAnimation {
                
                HStack(spacing: 12) {
                    
                    Spacer()
                    
                    CommonButton(title: "Huỷ bỏ", backgroundColor: .white, foregroundColor: .black, strokeColor: .black) {
                        
                        withAnimation(.smooth(duration: 0.5)) {
                            lastTranslation = oldTranslation
                        }
                        
                        // wait for move task to last translation end (0.5s)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            withAnimation(.smooth(duration: 0.2)) {
                                shadowHeight = 0
                            }
                        })
                        
                        //wait for shadow animation by delay 0.7s = 0.5(move task to last translation) + 0.2 (shadow animation)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                            isEdit = false
                        })
                        
                        withAnimation(.easeOut(duration: 0.3)) {
                            isEditWithAnimation = false
                        }
                    }
                    
                    
                    CommonButton(title: "Lưu", backgroundColor: .black, foregroundColor: .white, strokeColor: .black) {
                        withAnimation(.smooth(duration: 0.2)) {
                            shadowHeight = 0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            isEdit = false
                        })
                        
                        withAnimation(.easeIn(duration: 0.2)) {
                            isEditWithAnimation = false
                        }
                    }
                    
                    Spacer()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                
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
