//
//  UserViewModel.swift
//  FQADragDrogTableAnimation
//
//  Created by Ha Duyen Quang Huy on 12/04/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var listUsers: [UserModel]
    
    init() {
        self.listUsers = mockListUsers
    }
    
    func createUser() {
        
        let user = UserModel(name: "abcd", imageName: "person1")
        listUsers.append(user)
    }
}
