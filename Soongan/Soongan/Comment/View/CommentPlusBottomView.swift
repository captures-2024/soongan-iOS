//
//  CommentPlusBottomView.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

struct CommentPlusBottomView: View {
    
    var body: some View {
        VStack {
            Button {
                // TODO: 편집
            } label: {
                commentButtonLabel(title: "편집하기", icon: "icEdit")
                    .foregroundStyle(.black)
            }

            blackDivider

            Button {
                // TODO: 삭제
            } label: {
                commentButtonLabel(title: "삭제하기", icon: "icDelete")
                    .foregroundStyle(.black)
            }

            blackDivider

            Button {
                // TODO: 신고하기로 이동
            } label: {
                commentButtonLabel(title: "신고하기", icon: "icReport")
                    .foregroundStyle(Color.negative)
            }
        }
        .font(.system(size: 16, weight: .bold))
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
        .padding(.top, 56)
    }

    private var blackDivider: some View {
        Divider()
            .background(Color.primaryA.opacity(0.3))
    }

    private func commentButtonLabel(title: String, icon: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Image(icon)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
    }
}

#Preview {
    CommentPlusBottomView()
}
