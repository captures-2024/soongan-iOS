//
//  ContentView.swift
//  Soongan
//
//  Created by jun on 5/15/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import KakaoSDKAuth
import KakaoSDKUser

struct SignUpMainView: View {
    @StateObject var appState = AppState.shared
    // 로그인 여부
    @State private var isLogined = false
    @State private var userData: UserData

    
    public init(isLogined: Bool = false, userData: UserData) {
        _isLogined = State(initialValue: isLogined)
        _userData = State(initialValue: userData)
    }
    
    private var attributedString: AttributedString {
        let string = "계속하시면 이용약관 및 개인보호 정책에 동의하시게 됩니다."
        var attributedString = AttributedString(string)
        
        attributedString.font = .systemFont(ofSize: 12, weight: .medium)
        
        if let useRange = attributedString.range(of: "이용약관") {
           

            attributedString[useRange].underlineStyle = .single

        }
        
        if let privacyRange = attributedString.range(of: "개인보호 정책") {
           

            attributedString[privacyRange].underlineStyle = .single

        }
        
        return attributedString
    }
    
    var body: some View {
        
            NavigationStack(path: $appState.navigationPath) {
              
                    ZStack {
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: Constants.screenWidth, maxHeight: Constants.screenHeight)
                            .ignoresSafeArea()
                        BlackView()
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.5)
                        
                        VStack(spacing: 0) {
                            Text("순간")
                                .foregroundStyle(Color(hex: 0xF5F5F5))
                                .font(.system(size: 96, weight: .medium))
                                .padding(.top, 174)
                                .padding(.bottom, 76)
                            VStack(spacing: 16) {
                                snsButtonView(image: "icApple", title: "Apple로 로그인")
                                snsButtonView(image: "icGoogle", title: "Google로 로그인")
                                snsButtonView(image: "icKakao", title: "Kakao로 로그인")
                            }
                            .padding(.bottom, 16)
                            .navigationDestination(for: MainViewType.self) { viewType in
                                switch viewType {
                                case .apple:
                                    SignUpView()
                                case .google: // 구글 로그인 성공 시 SignUpView로 이동
                                    SignUpView()
                                case .kakao:
                                    SignUpView()
                                
                                }
                            }
                            
                            Text("\(attributedString)")
                                .foregroundStyle(Color(hex: 0xF5F5F5))
                                .padding(.bottom, 24)
                            Button(action: {}, label: {
                                Text("둘러보기")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color(hex: 0xF5F5F5))
                            })
                        }
                        Spacer()
                    }
            }
            .onAppear( perform: {
                // 로그인 상태 체크
                checkState()
            })
    }
    // 로그인 상태 체크
    func checkState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                print("Not Sign In")
            } else {
                guard let profile = user?.profile else { return }
                let data = UserData(name: profile.name, email: profile.email)
                userData = data
                isLogined = true
            }
        }
    }
}

struct BlackView: View {
    var body: some View {
        Color.black
    }
}

enum MainViewType {
    case google
    case kakao
    case apple
}

// sns버튼 뷰
struct snsButtonView: View {
    var image: String
    var title: String
    let authManager = AuthManager()
    
    var body: some View {
        
        Button(action: {
            switch title {
            case "Apple로 로그인":
                authManager.appleLogin()
            case "Google로 로그인":
                authManager.googleLogin()
            case "Kakao로 로그인":
                authManager.kakaoLogin()
            default:
                break
            }
            
        }, label: {
            ZStack() {
                HStack(spacing: 0) {
                    Image("\(image)")
                        .padding(.leading, 32)
                    Spacer()
                }
                Text("\(title)")
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .foregroundStyle(Color(hex: 0x252525))
            }
         
        })
        .frame(width: Constants.screenWidth - 32, height: (Constants.screenWidth - 32) * (56 / 361))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(hex: 0xF5F5F5))
                
        )
    }
}
               


#Preview {
    SignUpMainView(userData: UserData(name: "", email: ""))
}
