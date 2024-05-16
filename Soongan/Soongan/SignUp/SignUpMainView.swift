//
//  ContentView.swift
//  Soongan
//
//  Created by jun on 5/15/24.
//

import SwiftUI

struct SignUpMainView: View {
    
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
        VStack(spacing: 0) {
            Text("순간")
                .font(.system(size: 96, weight: .medium))
                .padding(.top, 174)
                .padding(.bottom, 76)
            VStack(spacing: 16) {
                snsButtonView(image: "icApple", title: "Apple로 로그인")
                snsButtonView(image: "icGoogle", title: "Google로 로그인")
                snsButtonView(image: "icKakao", title: "Kakao로 로그인")
            }
            .padding(.bottom, 16)
            
            Text("\(attributedString)")
                .padding(.bottom, 24)
            Button(action: {}, label: {
                Text("둘러보기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(hex: 0x252525))
            })
        }
        Spacer()
    }
}

// sns버튼 뷰
struct snsButtonView: View {
    var image: String
    var title: String
    
    var body: some View {
        
        Button(action: {
            
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
    SignUpMainView()
}
