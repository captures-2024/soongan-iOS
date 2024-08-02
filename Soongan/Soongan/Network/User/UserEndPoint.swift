//
//  UserEndPoint.swift
//  Soongan
//
//  Created by 김민 on 8/2/24.
//

import Foundation
import Alamofire

enum UserEndPoint {
    case checkNicknameValidation(parameter: String)
}

extension UserEndPoint: EndPoint {

    var baseURL: String {
        return "\(Secrets.baseUrl)/members"
    }
    
    var path: String {
        switch self {
        case .checkNicknameValidation:
            return "/check-nickname"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkNicknameValidation:
            return .get
        }
    }
    
    var task: APITask {
        var params: [String: Any] = [:]

        switch self {
        case let .checkNicknameValidation(parameter):
            params["nickname"] = parameter
            return .requestParameters(parameters: params)
        }
    }
}
