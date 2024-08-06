//
//  SubmitReportView.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

struct SubmitReportView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button {

                } label: {
                    Image("icLeft")
                }

                Spacer()

                Text("신고")
                    .font(.system(size: 16, weight: .bold))

                Spacer()
            }
            .padding(.top, 28)
            .padding(.bottom, 8)
            .padding(.horizontal, 20)

            Divider()

            Text("이 게시물을 도배로 정말 신고하겠습니까?")
                .lineLimit(2)
                .padding(.top, 40)
                .padding(.bottom, 48)
                .padding(.horizontal, 40)

            BlackButton(title: "신고 제출") {
                // TODO: push
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 28)
    }
}

#Preview {
    SubmitReportView()
}
