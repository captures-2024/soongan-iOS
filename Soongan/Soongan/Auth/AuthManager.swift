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
import AuthenticationServices

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
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    guard let idToken = oauthToken?.accessToken else { return }
                    self?.loginWithKakao(kakaoIdToken: idToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    guard let idToken = oauthToken?.accessToken else { return }
                    self?.loginWithKakao(kakaoIdToken: idToken)
                }
            }
        }
    }

    @MainActor
    private func loginWithKakao(kakaoIdToken: String) {
        guard let fcmToken = KeyChainManager.readItem(key: "FCMToken") else { return }
        let loginRequest = LoginRequest(
            provider: "KAKAO",
            idToken: kakaoIdToken,
            fcmToken: fcmToken) // TODO: fcm token 수정
        
        Task {
            await self.loginToServer(request: loginRequest, userAgent: "IOS")
            AppState.shared.navigationPath.append(MainViewType.kakao)
        }
    }

    // 애플 로그인
    @MainActor
    func appleLogin() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func loginToServer(request: LoginRequest, userAgent: String) async {
        let result = await AuthService.loginServer(body: request, userAgent: userAgent)
        print(result?.responseData?.accessToken)
        if let tokens = result?.responseData {
            print("Login to success")
            print("accessToken: \(tokens.accessToken)")
            print("refreshToken: \(tokens.refreshToken)")
            
            if KeyChainManager.itemExists(key: "accessToken") {
                print("accessToken 있음")
                KeyChainManager.updateItem(key: "accessToken", value: tokens.accessToken)
                KeyChainManager.updateItem(key: "refreshToken", value: tokens.refreshToken)
            } else {
                print("accessToken 없음")
                KeyChainManager.addItem(key: "accessToken", value: tokens.accessToken)
                KeyChainManager.addItem(key: "refreshToken", value: tokens.refreshToken)
            }
            
        } else if result?.statusCode == 404 {
            // 로그인 실패(404)인 경우 회원가입 필요
            print("회원가입 필요")
        }
    }
}

extension AuthManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    // 애플 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let userId = appleIdCredential.user
        var email = appleIdCredential.email ?? ""
        let idTokenData = appleIdCredential.identityToken
        let idTokenString = String(data: idTokenData!, encoding: .utf8) ?? ""
        // email이 비어있을 때(2번째 로그인 부터는 email이 identityToken에 들어있음)
        if email.isEmpty {
            if let tokenString = String(data: appleIdCredential.identityToken ?? Data(), encoding: .utf8) {
                email = decode(jwtToken: tokenString)["email"] as? String ?? ""
            }
        }
        
        if let authorizationCode = String(data: appleIdCredential.authorizationCode ?? Data(), encoding: .utf8) {
            KeyChainManager.addItem(key: "appleIdtoken", value: idTokenString)
            let loginRequest = LoginRequest(
                provider: "APPLE",
                idToken: idTokenString,
                fcmToken: "") // TODO: fcm token 수정
            Task {
                await self.loginToServer(request: loginRequest, userAgent: "IOS")
                
            }
        } else { // TODO: 토큰 못 가져오는 경우 ErrorHandler 처리
            print("토큰 못 가져옴")
        }
    }
    
    private func decode(jwtToken jwt: String) -> [String: Any] {
        func base64UrlDecode(_ value: String) -> Data? {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }
        
        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64UrlDecode(value),
                  let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
            }
            
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }

}
