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
import FirebaseCore
import FirebaseMessaging

@main
struct SoonganApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        KakaoSDK.initSDK(appKey: Bundle.main.kakaoKey)
    }

    var body: some Scene {
        WindowGroup {
            SignUpMainView(userData: UserData(name: "", email: ""))
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //서버에 FCM 정보 등록하기(처음 실행 됐을때만 실행 그 이후 실행 안 됨)
        
       
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
        application.registerForRemoteNotifications()
        
        // 파이어베이스 Meesaging 설정
        Messaging.messaging().delegate = self
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}

extension AppDelegate: MessagingDelegate {
    // 파이어베이스 MessagingDelegate 설정
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        guard let fcmToken else { return }
        
        if KeyChainManager.itemExists(key: "FCMToken") {
            print("FCM Token이 키체인에 이미 저장 되어 있음")
            KeyChainManager.updateItem(key: "FCMToken", value: fcmToken)
        } else {
            KeyChainManager.addItem(key: "FCMToken", value: fcmToken)
        }
        
        Task {
            let uuidData = UUID().uuidString
            let body = FCMRequest(token: fcmToken, deviceId: uuidData)
            let userAgent = "IOS"
            _ = await FCMService.FCMService(body: body, userAgent: userAgent)
        }
    }
}
