//
//  IconButton.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 12/04/2024.
//

import SwiftUI

struct IconButton: View {
    
    var backgroundColor: Color
    var iconName: String
    var onTap: () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(iconName)
                .resizable()
                .frame(width: 24, height: 24)
                .frame(width: 44, height: 44)
                .background(backgroundColor)
                .cornerRadius(22)
                .shadow(radius: 8)
                
        }
    }
}

#Preview {
    IconButton(backgroundColor: Color.white, iconName: "ic_gps", onTap: {})
}
