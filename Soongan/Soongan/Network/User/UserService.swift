//
//  UserService.swift
//  Soongan
//
//  Created by 김민 on 8/2/24.
//

import Foundation
import Alamofire

struct UserService {

    static func checkNicknameValidation(parameter: String) async -> BaseResponse<Bool>? {
        return await NetworkManager.shared.request(UserEndPoint.checkNicknameValidation(parameter: parameter))
    }
}

//struct AuthService {
//    static func loginServer(body: LoginRequest, userAgent: String) async -> BaseResponse<LoginRegisterResponse>? {
//        return await NetworkManager.shared.request(AuthEndPoint.login(body: body, userAgent: userAgent))
//    }
//}
