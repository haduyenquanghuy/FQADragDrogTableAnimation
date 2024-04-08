//
//  FontProvider.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct FontProvider {
    
    static var shared = FontProvider()
    
    private init() {
        
    }
    
    func latoFont(size: CGFloat, fontWeight: Font.Weight) -> Font {
        Font.custom("Lato", size: size)
            .weight(fontWeight)
    }
}
