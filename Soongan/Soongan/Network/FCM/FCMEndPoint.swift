//
//  FCMEndPoint.swift
//  Soongan
//
//  Created by 이득령 on 12/17/24.
//

import Foundation
import Alamofire

enum FCMEndPoint {
    case postFCM(body: FCMRequest, userAgent: String)
}

extension FCMEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)"
    }
    
    var path: String {
        switch self {
        case .postFCM:
            return "/fcm"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postFCM:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .postFCM(body, _): // login은 interceptor없이 요청!
            return .requestWithoutInterceptor(body: body)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case let .postFCM(body, userAgent): //userAgent 헤더로 보내기
            return ["Content-Type": "application/json", "User-Agent": "\(userAgent)"]
        }
    }
}
