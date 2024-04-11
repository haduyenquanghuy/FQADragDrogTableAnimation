//
//  UserView.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 08/04/2024.
//

import SwiftUI

struct UserView: View {
    
    let user: UserModel
    
    var body: some View {
        
        VStack(spacing: 4) {
            Image(user.imageName)
                .resizable()
                .frame(width: 44, height: 44)
            
            Text(user.name)
                .font(fontProvider.latoFont(size: 14, fontWeight: .regular))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ListUserRowView: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(mockListUsers) {
                UserView(user: $0)
                    .frame(width: AppConstant.rowWidth)
            }
        }
    }
}

#Preview {
    ListUserRowView()
}
