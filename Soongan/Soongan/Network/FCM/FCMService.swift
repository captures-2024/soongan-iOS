//
//  FCMService.swift
//  Soongan
//
//  Created by 이득령 on 12/17/24.
//

import Foundation
import Alamofire

struct FCMService {
    static func FCMService(body: FCMRequest, userAgent: String) async -> BaseResponse<FCMRegisterResponse>? {
        let userDefaults = UserDefaults.standard
        let hasLaunchedKey = "hasLaunchedBefore" // UserDefaults 키 이름
        
        // 첫 실행인지 체크
        if !userDefaults.bool(forKey: hasLaunchedKey) {
            print("앱이 처음 실행되었음. FCMService 함수 실행")
            
            // Task를 사용하여 비동기 실행
            Task {
                let response: BaseResponse<FCMRegisterResponse>? = await NetworkManager.shared.request(FCMEndPoint.postFCM(body: body, userAgent: userAgent))
                
                if let response = response, let data = response.responseData {
                    // 응답이 성공적으로 처리된 경우
                    print("FCM Token: \(data.deviceId)")
                    print("Device ID: \(data.token)")
                    
                    // 첫 실행임을 기록
                    userDefaults.set(true, forKey: hasLaunchedKey)
                } else {
                    // 실패한 경우
                    print("FCM 요청 실패: 응답이 없음")
                }
            }
            
            return nil
        } else {
            print("앱이 이미 실행된 적 있음. FCMService 함수 실행 안 함")
            return nil
        }
    }
}
