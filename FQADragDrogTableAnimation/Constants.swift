//
//  Constants.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import Foundation
import UIKit

let mockListUsers = [

    UserModel(name: "Anna", imageName: "person1"),
    UserModel(name: "John Doe", imageName: "person2"),
    UserModel(name: "David", imageName: "person3"),
    UserModel(name: "Rose", imageName: "person4"),
]

struct AppConstant {
    
    static let hourPerDay: Int = 23
    static let blockPerHour: Int = 4
    static let rowWidth = (UIScreen.main.bounds.width - AppConstant.hourLabelColumnWidth) / 3
    static let rowHeight: CGFloat = rowGridHeight * CGFloat(blockPerHour)
    static let rowGridHeight: CGFloat = 30    
    static let timeUnitPerBlock: Double = Double(60) / Double(blockPerHour)
    static let hourLabelColumnWidth: CGFloat = 44
    static let officeHour = 8.5 ..< 17.5
    static let childPerBlock = 3
    static let heightPerChild = rowGridHeight / CGFloat(childPerBlock)
}
