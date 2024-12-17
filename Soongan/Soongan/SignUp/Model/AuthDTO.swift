//
//  AuthDTO.swift
//  Soongan
//
//  Created by juni on 7/30/24.
//

import Foundation
// 로그인 요청보낼 body
struct LoginRequest: Codable {
    let provider: String
    let idToken: String
    let fcmToken: String
}
// 로그인 요청 response
struct LoginRegisterResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
