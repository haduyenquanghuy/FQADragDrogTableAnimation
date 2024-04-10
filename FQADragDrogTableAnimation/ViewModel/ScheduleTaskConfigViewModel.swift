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
    var currentConfigTask: TaskConfigModel?
    
    init() {
        self.positions = []
        self.config = []
    }
    
    func create(new pos: SchedulePositionModel) {
        positions.append(pos)
        config.append(TaskConfigModel())
    }
    
    func pos(at conf: TaskConfigModel) -> SchedulePositionModel? {
        
        if let index = config.firstIndex(where: { conf == $0 }) {
            return positions[index]
        }
        return nil
    }
    
    func cancelTranslation() {
        if let index = config.firstIndex(where: { currentConfigTask?.id == $0.id }) {
            
            // no change on translation
            if config[index].lastTranslation != config[index].oldTranslation {
                withAnimation(.smooth(duration: 0.5)) {
                    config[index].lastTranslation = config[index].oldTranslation
                }
                // wait for move task to last translation end (0.5s)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [self] in
                    withAnimation(.smooth(duration: 0.2)) {
                        config[index].shadowHeight = 0
                    }
                })
                
                //wait for shadow animation by delay 0.7s = 0.5(move task to last translation) + 0.2 (shadow animation)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [self] in
                    config[index].isEdit = false
                })
            } else {
                withAnimation(.smooth(duration: 0.2)) {
                    config[index].shadowHeight = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [self] in
                    config[index].isEdit = false
                })
            }
            
        }
        
        currentConfigTask = nil
    }
    
    func saveTranslation() {
        if let index = config.firstIndex(where: { currentConfigTask?.id == $0.id }) {
            withAnimation(.smooth(duration: 0.2)) {
                config[index].shadowHeight = 0
            }
            
            // wait for shadow animation end by 0.2s delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [self] in
                config[index].isEdit = false
            })
        }
        currentConfigTask = nil
    }
    
    func setCurrent(config: TaskConfigModel) {
        self.currentConfigTask = config
    }
    
    func roundPosition(size: CGSize) -> CGSize {
        
        // set min and max limit so task dont out of schedule
        let rW = round((size.width) / AppConstant.rowWidth)
        let rH = round((size.height) / AppConstant.rowHeight)
        
        return CGSize(width: rW * AppConstant.rowWidth, height: rH * AppConstant.rowHeight)
    }
}
