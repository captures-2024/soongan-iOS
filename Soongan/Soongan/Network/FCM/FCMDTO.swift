//
//  FCMDTO.swift
//  Soongan
//
//  Created by 이득령 on 12/17/24.
//

import Foundation

// FCM 요청보낼 body
struct FCMRequest: Codable {
    let token: String
    let deviceId: String
}
// fcm 요청 response
//struct FCMRegisterResponse: Codable {
//    let id: Int
//    let token: String
//    let deviceId: String
//    let deviceType: String
//}

struct FCMRegisterResponse: Codable {
    let id: Int
    let token, deviceId, deviceType: String

}

// MARK: - ResponseData
struct ResponseData: Codable {
    let id: Int
    let token, deviceId, deviceType: String

    
}

