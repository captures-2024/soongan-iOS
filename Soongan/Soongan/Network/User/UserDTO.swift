//
//  UserDTO.swift
//  Soongan
//
//  Created by 이득령 on 12/19/24.
//

import Foundation

// 유저 데이터 보낼 body
struct ProfileRequest: Codable {
    let nickname: String
    let selfIntroduction: String
    let profileImage: String
}
// 유저데이터 요청 response
struct ProfileRegisterResponse: Codable {
    let statusCode: Int
    let message: String
    let responseData: [String: String]?
}
struct ProfileResponseData: Codable {
}


struct BirthYearRequest: Encodable {
    let birthday: Int?
}

struct BirthYearResponse: Codable {
    let statusCode: String
    let message: String
}
