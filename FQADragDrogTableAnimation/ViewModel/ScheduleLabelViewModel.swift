//
//  ScheduleLabelViewModel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 11/04/2024.
//

import Foundation
import Combine

class ScheduleLabelViewModel: ObservableObject {
    
    var heightOffset: CGFloat = 0
    
    lazy private var dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        
        return dateFormatter
    }()
    
    private var cancellable: AnyCancellable? = nil
    
    var timeStr: String = ""
    
    @Published var currentTime: Date = Date() {
        didSet {
            timeStr = dateFormatter.string(from: currentTime)
        }
    }
    
    init() {
        self.update()
        
        cancellable = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] value in
                self?.update()
            })
    }
    
    func update() {
        currentTime = Date()
        
        let calendar = Calendar.current
        // get current hour
        let hour = calendar.component(.hour, from: currentTime)
        let minutes = calendar.component(.minute, from: currentTime)
        
        heightOffset = (CGFloat(hour) + CGFloat(minutes) / 60) * AppConstant.rowHeight
    }
}
