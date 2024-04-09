//
//  SchedulePositionModel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 09/04/2024.
//
struct SchedulePositionModel: Identifiable {
    
    var index: Int
    var row: Int
    var column: Int
    
    var id: String {
        return "\(index)-\(row)-\(column)"
    }
}
