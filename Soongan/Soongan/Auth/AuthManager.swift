//
//  AuthManager.swift
//  Soongan
//
//  Created by juni on 6/12/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import KakaoSDKUser

// 소셜 로그인을 다루는 매니저
final class AuthManager: NSObject {
    
    // 구글 로그인
    @MainActor
    func googleLogin() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            guard let result = signInResult else {
                return
            }
            guard let profile = result.user.profile else { return }
            
            result.user.refreshTokensIfNeeded { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                
                let idToken = result.user.idToken
                print("idToken: \(idToken?.tokenString)")
            }
            AppState.shared.navigationPath.append(MainViewType.google)
        }
    }

    @MainActor
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("oauthToken:", oauthToken)

                    AppState.shared.navigationPath.append(MainViewType.kakao)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("oauthToken:", oauthToken)
                }

                AppState.shared.navigationPath.append(MainViewType.kakao)
            }
        }
    }
}
