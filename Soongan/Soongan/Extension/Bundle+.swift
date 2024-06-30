//
//  Bundle+.swift
//  Soongan
//
//  Created by 김민 on 7/1/24.
//

import Foundation

extension Bundle {

    var kakaoKey: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("plist 파일 찾을 수 없음")
        }

        guard let value = plistDict.object(forKey: "KakaoNativeAppKey") as? String else {
            fatalError("key값 찾을 수 없음")
        }

        return value
    }
}
