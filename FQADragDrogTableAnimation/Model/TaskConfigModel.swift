//
//  TaskConfigModel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 10/04/2024.
//

import Foundation

struct TaskConfigModel: Identifiable, Equatable {
    
    var shadowHeight: Double = 0
    var oldTranslation = CGSize.zero
    var lastTranslation = CGSize.zero
    var translation = CGSize.zero
    var isEdit = false
    
    var id = UUID()
}
