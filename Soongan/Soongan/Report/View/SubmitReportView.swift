//
//  SubmitReportView.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

struct SubmitReportView: View {
    @Binding var selectedReportViewType: ReportViewType
    var reportCase: ReportCases

    var body: some View {
        VStack(spacing: 0) {
            ModalHandler()
                .padding(.bottom, 10)

            HStack(spacing: 0) {
                Button {
                    selectedReportViewType = .reportCase
                } label: {
                    Image("icLeft")
                }

                Spacer()

                Text("신고")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, 8)
                    .offset(x: -20)

                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 8)
            .padding(.leading, 20)

            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("이 댓글을")
                    Text("\"\(reportCase.title)\"(으)로")
                    Text("정말 신고하시겠습니까?")
                }

                Spacer()
            }
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 17)
            .padding(.leading, 40)

            Spacer()

            BlackButton(title: "신고 제출") {
                selectedReportViewType = .reportCompleted
            }
            .padding(.bottom, 28)
            .padding(.horizontal, 20)
        }
        .background(Color.white)
    }
}

#Preview {
    SubmitReportView(
        selectedReportViewType: .constant(.reportCompleted),
        reportCase: .inappropriate
    )
}
