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
    case profileToServer(body: ProfileRequest)
    case birthYearToServer(body: Int)
}

extension UserEndPoint: EndPoint {

    var baseURL: String {
        return "\(Secrets.baseUrl)/members"
    }
    
    var path: String {
        switch self {
        case .checkNicknameValidation:
            return "/check-nickname"
        case .profileToServer:
            return "/profile"
        case .birthYearToServer:
            return "/birth-year"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkNicknameValidation:
            return .get
        case .profileToServer, .birthYearToServer:
            return .patch
        }
    }
    
    var task: APITask {
        var params: [String: Any] = [:]
        
        switch self {
        case let .checkNicknameValidation(parameter):
            params["nickname"] = parameter
            print("Requesting nickname validation with params: \(params)")
            return .requestParameters(parameters: params)
            
        case .profileToServer(body: let body):
            let multipartFile: [Data?] = [] // 필요한 경우 파일 데이터 추가
            print("Sending profile data: \(body)")
            return .requestJSONWithImage(multipartFile: multipartFile, body: body, withInterceptor: false)
            
        case let .birthYearToServer(body):
            print("Sending birth year: \(body)")
            return .requestJSONEncodable(body: body)
        }
    }
    
    var headers: HTTPHeaders? {
        let authorization = "Bearer \(KeyChainManager.readItem(key: "accessToken") ?? "NoToken")"
        print("Authorization Header: \(authorization)")
        
        switch self {
        case .checkNicknameValidation:
            return ["Content-Type": "application/json",
                    "Authorization": "\(authorization)"]
            
        case .profileToServer:
            return ["Content-Type": "multipart/form-data",
                    "Authorization": "\(authorization)"]
            
        case .birthYearToServer:
            return ["Content-Type": "application/json",
                    "Authorization": "\(authorization)"]
        }
    }
}
