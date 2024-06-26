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
    var tasks: [TaskModel]
    var currentConfigTask: TaskConfigModel?
    
    init() {
        self.positions = []
        self.config = []
        self.tasks = []
    }
    
    private func updateTask(index: Int) {
        let curConf = config[index]
        
        let offset = CGFloat(curConf.lastTranslation.height) / AppConstant.rowHeight
        let startTime = CGFloat(positions[index].index) + offset
        let endTime = startTime + 1
        
        tasks[index] = TaskModel(
            startTime: convertToDateString(with: startTime),
            endTime: convertToDateString(with: endTime),
            content: tasks[index].content)
    }
    
    private func createTask(with pos: SchedulePositionModel) -> TaskModel {
        TaskModel(startTime: convertToDateString(with: CGFloat(pos.index)),
                  endTime: convertToDateString(with: CGFloat(pos.index + 1)),
                  content: "abcdef")
    }
    
    private func convertToDateString(with index: CGFloat) -> String {
        
        let hours = floor(index)
        let minutes = index.truncatingRemainder(dividingBy: 1) * 60
        
        return String(format: "%01dh%02dp", Int(hours), Int(minutes.rounded()))
    }
    
    private func index(at conf: TaskConfigModel) -> Int? {
        
        config.firstIndex { conf == $0 }
    }
    
    func postionX(at pos: SchedulePositionModel?, conf: TaskConfigModel?) -> CGFloat {
        guard let pos = pos, let conf = conf else { return 0 }
        
        let offset = conf.lastTranslation.height / AppConstant.rowHeight
        return offset + CGFloat(pos.index)
    }
    
    func create(new pos: SchedulePositionModel) {
        positions.append(pos)
        config.append(TaskConfigModel())
        tasks.append(createTask(with: pos))
    }
    
    func pos(at conf: TaskConfigModel) -> SchedulePositionModel? {
        
        index(at: conf).map { positions[$0] }
    }

    
    func task(at conf: TaskConfigModel) -> TaskModel? {
        
        index(at: conf).map { tasks[$0] }
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
                updateTask(index: index)
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
        let rH = round((size.height) / AppConstant.heightPerChild)
        
        return CGSize(width: rW * AppConstant.rowWidth, height: rH * AppConstant.heightPerChild)
    }
    
    func isOfficeHour(at index: Int, and row: Int) -> Bool {
        AppConstant.officeHour ~= CGFloat(index) + CGFloat(row) / CGFloat(AppConstant.blockPerHour)
    }
}
