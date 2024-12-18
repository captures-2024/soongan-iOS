//
//  AuthEndPoint.swift
//  Soongan
//
//  Created by juni on 7/30/24.
//

import Foundation
import Alamofire

enum AuthEndPoint {
    case login(body: LoginRequest, userAgent: String)
}

extension AuthEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/auth"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .login(body, _): // login은 interceptor없이 요청!
            return .requestWithoutInterceptor(body: body)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case let .login(body, userAgent): //userAgent 헤더로 보내기
            return ["Content-Type": "application/json", "User-Agent": "\(userAgent)"]
        }
    }
}
