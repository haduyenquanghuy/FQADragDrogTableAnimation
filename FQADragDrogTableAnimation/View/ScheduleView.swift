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
    
    @StateObject private var vm = ScheduleTaskConfigViewModel()
    @StateObject private var userVM = UserViewModel()
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            ScrollView([.horizontal], showsIndicators: false) {
                ScheduleTableContentView(offset: $offset,
                                         isEdit: $isEdit,
                                         blockScrollWhenDragTask: $blockScrollWhenDragTask)
                .background( GeometryReader { geo in
                    Color.clear
                        .preference(key: ViewOffsetKey.self,
                                    value: geo.frame(in: .named("scroll")).origin)
                })
                .padding(.bottom, isEdit ? 56 : 0)
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
                        
                        vm.cancelTranslation()
                        
                        withAnimation(.linear(duration: 0.4)) {
                            isEdit = false
                        }
                    }
                    
                    
                    CommonButton(title: "Lưu", backgroundColor: .black, foregroundColor: .white, strokeColor: .black) {
                        
                        vm.saveTranslation()
                        
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
        .overlay(alignment: .bottomTrailing, content: {
            
            if !isEdit {
                VStack(spacing: 12) {
                    IconButton(backgroundColor: .white, iconName: "ic_gps", onTap: {
                        
                    })
                    
                    IconButton(backgroundColor: .black, iconName: "ic_plus", onTap: {
                        userVM.createUser()
                    })
                }
                .padding([.trailing, .bottom])
                .transition(.move(edge: .trailing))
            } else {
                EmptyView()
            }
        })
        .coordinateSpace(name: "scroll")
        .environmentObject(vm)
        .environmentObject(userVM)
        .ignoresSafeArea(edges: .vertical)
        .padding(.vertical, 1)
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
