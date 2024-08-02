//
//  UserEndPoint.swift
//  Soongan
//
//  Created by 김민 on 8/2/24.
//

import Foundation
import Alamofire

enum UserEndPoint {

}

extension UserEndPoint: EndPoint {

    var baseURL: String {
        return "\(Secrets.baseUrl)/members"
    }
    
    var path: String {
        switch self {

        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {

        }
    }
    
    var task: APITask {
        switch self {
            
        }
    }
}
