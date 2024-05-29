//
//  AppState.swift
//  Soongan
//
//  Created by jun on 5/29/24.
//

import SwiftUI

@MainActor
class AppState: ObservableObject {
    static let shared = AppState()
    
    // naviagation Path
    @Published var navigationPath = NavigationPath()
    // 회원가입 시 유저 닉네임
    @Published var nickName = ""
}
