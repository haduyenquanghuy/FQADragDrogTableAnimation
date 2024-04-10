//
//  Constants.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import Foundation
import UIKit

let mockListUsers = [

    UserModel(id: "1", name: "Anna", imageName: "person1"),
    UserModel(id: "2", name: "John Doe", imageName: "person2"),
    UserModel(id: "3", name: "David", imageName: "person3"),
    UserModel(id: "4", name: "Rose", imageName: "person4"),
]

struct AppConstant {
    
    static let hourPerDay: Int = 23
    static let blockPerHour: Int = 4
    static let rowWidth = (UIScreen.main.bounds.width - 36) / 3
    static let rowHeight: CGFloat = rowGridHeight * CGFloat(blockPerHour)
    static let rowGridHeight: CGFloat = 30    
}
