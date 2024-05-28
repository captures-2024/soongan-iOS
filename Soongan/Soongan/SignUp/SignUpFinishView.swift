//
//  SignUpFinishView.swift
//  Soongan
//
//  Created by jun on 5/16/24.
//

import SwiftUI

struct SignUpFinishView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            BlackView()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            Spacer()
            VStack(spacing: 0) {
                Text("환영합니다")
                    .foregroundStyle(Color(hex: 0xF5F5F5))
                Spacer()
                Text("김첨지님!")
                    .foregroundStyle(Color(hex: 0xF5F5F5))
            }
            .font(.system(size: 36, weight: .semibold))
            .frame(height: 132)
            Spacer()
        }
       
    }
}

#Preview {
    SignUpFinishView()
}
