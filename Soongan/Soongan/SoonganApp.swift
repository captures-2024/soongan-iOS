//
//  SoonganApp.swift
//  Soongan
//
//  Created by jun on 5/15/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct SoonganApp: App {

    init() {
        KakaoSDK.initSDK(appKey: Bundle.main.kakaoKey)
    }

    var body: some Scene {
        WindowGroup {
//            SignUpMainView(userData: UserData(name: "", email: ""))
//                .onOpenURL { url in
//                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
//                        _ = AuthController.handleOpenUrl(url: url)
//                    }
//                }
            SignUpView()
//            ContestOutlineView()
        }
    }
}
