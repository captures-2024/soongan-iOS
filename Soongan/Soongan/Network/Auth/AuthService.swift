//
//  AuthService.swift
//  Soongan
//
//  Created by juni on 7/30/24.
//

import Foundation
import Alamofire

struct AuthService {
    static func loginServer(body: LoginRequest, userAgent: String) async -> BaseResponse<LoginRegisterResponse>? {
        return await NetworkManager.shared.request(AuthEndPoint.login(body: body, userAgent: userAgent))
    }
}
