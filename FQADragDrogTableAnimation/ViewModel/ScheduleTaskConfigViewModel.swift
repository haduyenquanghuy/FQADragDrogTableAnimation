//
//  ScheduleTaskConfigViewModel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 10/04/2024.
//

import SwiftUI

class ScheduleTaskConfigViewModel: ObservableObject {
    
    @Published var positions: [SchedulePositionModel]
    @Published var config: [TaskConfigModel]
    
    init() {
        self.positions = []
        self.config = []
    }
    
    func create(new pos: SchedulePositionModel) {
        positions.append(pos)
        let newConfig = TaskConfigModel()
        config.append(newConfig)
    }
}
